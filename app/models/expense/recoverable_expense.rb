class Expense::RecoverableExpense < Expense

	has_many :pending_expenses, class_name: "Expense::PendingExpense", foreign_key: :parent_id , dependent: :destroy

	validates :total_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :expected_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :recovered_spends, presence: true, numericality: { greater_than_or_equal_to: 0 }

	before_destroy :cancel_owes
	after_update :update_owes, :if => :saved_change_to_recovered_spends?

	def self.create_for_user(user,params = {})
		new_expense = new
		new_expense.expense_type = ExpenseType.find_or_create_for_user(user,params[:type])
		new_expense.description = params[:description] || "a shared expense"
		new_expense.owner = User.find(params[:paid_by][:user_id])
		new_expense.cycle = ExpenseCycle::SharedExpenseCycle.find(params[:cycle_id])
		if params[:shareSplitType] == "Equal"
			new_expense.total_spends = params[:spends]/params[:participants].pluck(:user_id).uniq.count
			new_expense.expected_spends = params[:spends] - (params[:spends]/params[:participants].pluck(:user_id).uniq.count)
		elsif params[:shareSplitType] == "Manual"
			new_expense.total_spends = params[:shareSplit][params[:paid_by][:user_id]]
			new_expense.expected_spends = params[:spends] - params[:shareSplit][params[:paid_by][:user_id]]
			raise ArgumentError if params[:shareSplit].values.reduce(0,:+) != params[:spends]
		end
		new_expense.save	
		params[:participants].pluck(:user_id).uniq.each{|prtcp_id|
			next if prtcp_id == params[:paid_by][:user_id]
			Expense::PendingExpense.create(
					:expense_type => new_expense.expense_type,
					:cycle => ExpenseCycle::SharedExpenseCycle.find(params[:cycle_id]),
					:description => new_expense.description,
					:owner => User.find(prtcp_id),
					:total_spends => params[:spends],
					:expected_spends => (params[:shareSplitType] == "Equal") ? new_expense.total_spends : params[:shareSplit][prtcp_id],
					:parent_id => new_expense.id
				)
		}
		new_expense.update_owes
		new_expense
	end

	def update_owes
		updated_owe = ActiveRecord::Base.connection.execute "SELECT  sum(expected_spends) - sum(recovered_spends) FROM `expenses` WHERE `expenses`.`type` IN ('#{self.class.name}') AND `expenses`.`owner_id` = #{owner_id} AND `expenses`.`cycle_id` = #{cycle.id}"
		updated_owe = updated_owe.first.first
		my_prtcp = Participant.find_by(:participant_id => owner_id, :cycle_id => cycle.id)
		puts "UPDATED OWE::::: #{updated_owe}"
		puts "UPDATED Participant::::: #{my_prtcp.id}"
		my_prtcp.update_column(:total_owe,updated_owe)
	end

	def cancel_owes
		my_prtcp = Participant.find_by(:participant_id => owner_id, :cycle_id => cycle.id)
		updated_owe = partcp.total_owe + recovered_spends - expected_spends
		my_prtcp.update_column(:total_owe,updated_owe)
	end

	def get_shares
		shares = []
		pending_expenses.each{|pndg_exp|
			shares << OpenStruct.new(:user_id => pndg_exp.owner_id,:cycle_id => pndg_exp.cycle_id,:share_type => "Owe",:shares_between => User.find(pndg_exp.owner_id),:spend => pndg_exp.expected_spends - pndg_exp.recovered_spends)
		}
		shares
	end
end

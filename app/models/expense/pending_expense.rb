class Expense::PendingExpense < Expense
	
	belongs_to :parent, class_name: "Expense::RecoverableExpense"	
	
	validates :parent_id, presence: true
	validates :total_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :expected_spends, presence: true, numericality: { greater_than_or_equal_to: 1 }
	validates :recovered_spends, presence: true, numericality: { greater_than_or_equal_to: 0 }

	after_update :update_shares, :update_dues , :if => :saved_change_to_recovered_spends?
	after_create :update_dues
	before_destroy :cancel_dues

	def update_shares
		new_total_recovered = parent.pending_expenses.pluck(:recovered_spends).reduce(0,:+)
		parent.update_attribute(:recovered_spends,new_total_recovered)
	end

	def update_dues
		updated_due = ActiveRecord::Base.connection.execute "SELECT  sum(expected_spends) - sum(recovered_spends) FROM `expenses` WHERE `expenses`.`type` IN ('#{self.class.name}') AND `expenses`.`owner_id` = #{owner_id} AND `expenses`.`cycle_id` = #{cycle.id}"
		updated_due = updated_due.first.first
		my_prtcp = Participant.find_by(:participant_id => owner_id, :cycle_id => cycle.id)
		my_prtcp.update_column(:total_due,updated_due)
	end

	def cancel_dues
		my_prtcp = Participant.find_by(:participant_id => owner_id, :cycle_id => cycle.id)
		updated_owe = partcp.total_due + recovered_spends - expected_spends
		my_prtcp.update_column(:total_due,updated_owe)
	end

	def update_spends(params = {})
		new_recovered = recovered_spends + params[:spend]
		raise ArgumentError if new_recovered > expected_spends
		self.recovered_spends = new_recovered
		self.save
	end

	def get_shares
		[OpenStruct.new(:user_id => parent.owner_id,:cycle_id => parent.cycle_id,:share_type => "Due",:shares_between => User.find(parent.owner_id),:spend => expected_spends - recovered_spends)]
	end

end

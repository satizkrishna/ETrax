class ExpenseCycle::SharedExpenseCycle < ExpenseCycle

	has_many :expenses, as: :cycle	
	has_many :participants, foreign_key: :cycle_id
	has_many :participating_users, class_name: :User, through: :participants, source: :user

	validates :title, presence: true
	validates :owner_id, presence: true

	def self.get_all_cycles(user,options = {})
		result = user.shared_expense_cycles
		if options[:cycle_id]
			result = result.find(options[:cycle_id])
		end
		result
	end

	def self.create_for_user(user,params = {})
		new_shared_cycle = new
		new_shared_cycle.owner = user
		new_shared_cycle.title = params[:title]
		new_shared_cycle.description = params[:description]
		new_shared_cycle.save
		params[:participants].each{|prtcp|
			new_shared_cycle.participants << Participant.create(:user => User.find(prtcp[:user_id]) ,:cycle => new_shared_cycle)
		}
	end

	def get_shares_for(user)
		dues = ActiveRecord::Base.connection.execute "SELECT recvr_exp.owner_id , sum(expenses.expected_spends) - sum(expenses.recovered_spends) due FROM `expenses` inner join expenses as recvr_exp on recvr_exp.type = 'Expense::RecoverableExpense' and expenses.parent_id = recvr_exp.id WHERE `expenses`.`type` IN ('Expense::PendingExpense') AND `expenses`.`owner_id` = #{user.id} AND `expenses`.`cycle_id` = #{id} GROUP BY recvr_exp.owner_id having due > 0"
		owes = ActiveRecord::Base.connection.execute "SELECT pndg_exp.owner_id , sum(pndg_exp.expected_spends) - sum(pndg_exp.recovered_spends) owe FROM `expenses` inner join expenses as pndg_exp on pndg_exp.type = 'Expense::PendingExpense' and expenses.id = pndg_exp.parent_id WHERE `expenses`.`type` IN ('Expense::RecoverableExpense') AND `expenses`.`owner_id` = #{user.id} AND `expenses`.`cycle_id` = #{id} GROUP BY pndg_exp.owner_id having owe > 0"
		shares = []
		(dues.to_h.keys - owes.to_h.keys).each{|user_id|
			shares << OpenStruct.new(:user_id => user_id,:cycle_id => self.id,:share_type => "Due",:shares_between => User.find(user_id),:spend => due.to_h[user_id])
		}
		(owes.to_h.keys - dues.to_h.keys).each{|user_id|
			shares << OpenStruct.new(:user_id => user_id,:cycle_id => self.id,:share_type => "Owe",:shares_between => User.find(user_id),:spend => owe.to_h[user_id])
		}
		(dues.to_h.keys & owes.to_h.keys).each{|user_id|
			diff = dues.to_h[user_id] - owes.to_h[user_id]
			if diff > 0
				shares << OpenStruct.new(:user_id => user_id,:cycle_id => self.id,:share_type => "Due",:shares_between => User.find(user_id),:spend => diff)
			else
				shares << OpenStruct.new(:user_id => user_id,:cycle_id => self.id,:share_type => "Owe",:shares_between => User.find(user_id),:spend => (-1) * diff)
			end
		}
		shares
	end

end

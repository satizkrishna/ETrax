class GraphqlDecorators::SharedExpenseCycleDecorator < GraphqlDecorator

	def no_of_participants
		@object.participants.count
	end

	def participants
		@object.participants
	end

	def total_due
		@object.participants.find_by(:participant_id => Current.user.id).total_due
	end
	
	def total_owe
		@object.participants.find_by(:participant_id => Current.user.id).total_owe
	end
	
	def shares
		@object.get_shares_for(Current.user)
	end

	def my_expenses
		@object.expenses.where(:owner_id => Current.user.id)
	end
	
end

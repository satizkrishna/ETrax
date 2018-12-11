class GraphqlDecorators::SharedExpenseDecorator < GraphqlDecorator

	def shared_cycle_id
		@object.cycle_id
	end

	def title
		@object.expense_type.title
	end

	def type
		@object.expense_type
	end

	def my_diff_spend
		@object.expected_spends - @object.recovered_spends
	end

	def shares
		@object.get_shares		
	end

end
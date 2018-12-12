class GraphqlDecorators::ForwardExpenseDecorator < GraphqlDecorator

	def monthly_cycle_id
		@object.cycle_id
	end

	def type
		@object.expense_type
	end

	def title
		@object.expense_type.title
	end

	def spends
		@object.total_spends
	end

end
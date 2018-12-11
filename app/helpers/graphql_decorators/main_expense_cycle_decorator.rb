class GraphqlDecorators::MainExpenseCycleDecorator < GraphqlDecorator

	def total_spend
		@object.spends
	end

end
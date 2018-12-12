class GraphqlDecorators::UserDecorator < GraphqlDecorator

	def current_cycle
		@object.get_current_cycle
	end

	def past_cycles
		@object.get_past_cycles
	end

	def shared_cycles
		@object.get_shared_cycles
	end

	def expense_types
		@object.my_expense_types
	end

end
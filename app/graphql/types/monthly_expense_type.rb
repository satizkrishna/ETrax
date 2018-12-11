Types::MonthlyExpenseType = GraphQL::ObjectType.define do
    name 'MonthlyExpense'
    description 'A Monthly expense'

	field :id, !types.Int
	field :monthly_cycle_id, types.Int

	field :title, types.String
	field :description, types.String

	field :type, Types::ExpenseTypesType
	field :spends, types.Float

end

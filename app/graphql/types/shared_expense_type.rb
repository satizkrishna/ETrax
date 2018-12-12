Types::SharedExpenseType = GraphQL::ObjectType.define do
    name 'SharedExpense'
    description 'A shared expense'

	field :id, !types.Int
	field :shared_cycle_id, types.Int

	field :title, types.String
	field :description, types.String

	field :type, Types::ExpenseTypesType
	field :paid_by, types.String
	field :share_type, types.String
	field :total_spend, types.Float
	field :my_spend, types.Float
	field :my_diff_spend, types.Float
	field :shares, types[Types::SharesType]
	interfaces [Types::Interfaces::TimeStampInterface]

end

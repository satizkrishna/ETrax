Types::MonthlyCycleType = GraphQL::ObjectType.define do
    name 'MonthlyCycle'
    description 'A Monthly cycle'

	field :id, !types.Int
	field :title, types.String
	field :description, types.String
	field :starts_at, GraphQL::Types::ISO8601DateTime
	field :expires_at, GraphQL::Types::ISO8601DateTime

	field :total_spend, types.Float
	field :expenses, types[Types::MonthlyExpenseType]

end

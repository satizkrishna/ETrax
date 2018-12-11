Types::ExpenseProfileType = GraphQL::ObjectType.define do
    name 'ExpenseProfile'
    description 'An expense profile'

	field :id, !types.Int
	field :user_id, !types.Int
	field :funds, types.Float
	field :starts_at_day, types.Int
	field :can_alert, types.Boolean

end

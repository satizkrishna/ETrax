Types::UserType = GraphQL::ObjectType.define do
    name 'User'
    description 'A user'

	field :id, !types.Int
	field :email, types.String
	field :uname, types.String
	field :expense_profile, Types::ExpenseProfileType
	field :expense_types, types[Types::ExpenseTypesType]
	field :current_cycle, Types::MonthlyCycleType
	field :past_cycles, types[Types::MonthlyCycleType]
	field :shared_cycles, types[Types::SharedCycleType]

end

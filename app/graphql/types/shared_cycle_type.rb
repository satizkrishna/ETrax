Types::SharedCycleType = GraphQL::ObjectType.define do
    name 'SharedCycle'
    description 'A Shared cycle'

	field :id, !types.Int
	field :title, types.String
	field :description, types.String
	field :no_of_participants, types.Int
	field :participants, types[Types::ParticipantType]

	field :total_due, types.Float
	field :total_owe, types.Float
	field :my_expenses, types[Types::SharedExpenseType]
	field :shares, types[Types::SharesType]
	interfaces [Types::Interfaces::TimeStampInterface]

end

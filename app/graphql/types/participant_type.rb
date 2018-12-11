Types::ParticipantType = GraphQL::ObjectType.define do
    name 'Participant'
    description 'A Participant'

	field :participant_id, !types.Int
	field :total_due, types.Float
	field :total_owe, types.Float
	field :name, types.String

end

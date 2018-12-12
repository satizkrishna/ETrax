module Types
  module Input
    ParticipantsInputType = GraphQL::InputObjectType.define do
      name 'ParticipantsInputType'
      description 'Participants field'

      argument :user_id, !types.Int
      argument :name, types.String
  	end
  end
end
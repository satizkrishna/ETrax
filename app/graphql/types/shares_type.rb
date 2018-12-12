Types::SharesType = GraphQL::ObjectType.define do
    name 'Share'
    description 'A share summary of a shared cycle'

	field :user_id, types.Int
	field :cycle_id, types.Int
	field :share_type, types.String
	field :shares_between, Types::UserType
	field :spend, types.Float

end

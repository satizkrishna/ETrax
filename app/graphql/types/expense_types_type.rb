Types::ExpenseTypesType = GraphQL::ObjectType.define do
    name 'ExpenseType'
    description 'An expense type'

	field :id, !types.Int
	field :title, types.String

end

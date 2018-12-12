module Queries

	UserQuery = GraphQL::ObjectType.define do
	    name 'User'
	    description 'Current user'

		field :user do
		 type Types::UserType
		 resolve Resolvers::AuthorizeUser.new( ->(obj, args, ctx) {
      		ctx[:current_user]
    		})
		end

	end

end
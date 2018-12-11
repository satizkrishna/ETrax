module Queries

	MonthlyCycleQuery = GraphQL::ObjectType.define do
	    name 'MonthlyCycle'
	    description 'A monthly cycle info'

	    field :past_cycles do
	     argument :cycle_id, !types.Int	
		 type Types::MonthlyCycleType
		 resolve Resolvers::AuthorizeUser.new( ->(obj, args, ctx) {
      			ctx[:current_user].get_past_cycles.find(args[:cycle_id])
    		})
		end

	end

end
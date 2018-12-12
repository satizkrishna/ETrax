module Queries

	MonthlyCycleQuery = GraphQL::ObjectType.define do
	    name 'MonthlyCycle'
	    description 'A monthly cycle info'

	    field :monthly_cycle do
	     argument :cycle_id, !types.Int	
		 type Types::MonthlyCycleType
		 resolve Resolvers::AuthorizeUser.new( ->(obj, args, ctx) {
      			ctx[:current_user].monthly_expense_cycles.find(args[:cycle_id])
    		})
		end

	end

end
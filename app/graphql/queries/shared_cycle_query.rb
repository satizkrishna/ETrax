module Queries

	SharedCycleQuery = GraphQL::ObjectType.define do
	    name 'SharedCycle'
	    description 'A shared cycle info'

		field :shared_cycles do
		 argument :cycle_id, !types.Int
		 type Types::SharedCycleType
		 resolve Resolvers::AuthorizeUser.new( ->(obj, args, ctx) {
      			ctx[:current_user].get_shared_cycles.find(args[:cycle_id])
    		})
		end

		field :shared_expense do
		 argument :expense_id, !types.Int
		 type Types::SharedExpenseType
		 resolve Resolvers::AuthorizeUser.new( ->(obj, args, ctx) {
      			Expense.find_by(:id => args[:expense_id], :owner_id => ctx[:current_user].id)
    		})
		end

	end

end
module Mutations

	MonthlyCycleMutation = GraphQL::ObjectType.define do
	  name 'SharedCycleMutation'

	  field :createMonthlyExpense, types.String do
	    description "field to create a new monthly expense"
        argument :type, !types.String
	    argument :description, types.String
	    argument :spends, !types.Float

	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].add_current_expense(args.to_h.with_indifferent_access)
	    }
	  end

	  field :updateMonthlyExpense, types.String do
	    description "field to update a new monthly expense"
        argument :expense_id, !types.Int
	    argument :spends, !types.Float

	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].update_current_expense(args.to_h.with_indifferent_access)
	    }
	  end

	  field :deleteMonthlyExpense, types.String do
	    description "field to delete a new monthly expense"
        argument :expense_id, !types.Int

	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].delete_current_expense(args.to_h.with_indifferent_access)
	    }
	  end

	end
end
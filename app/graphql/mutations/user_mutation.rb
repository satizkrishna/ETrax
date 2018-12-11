module Mutations

	UserMutation = GraphQL::ObjectType.define do
	  name 'SharedCycleMutation'

	  field :updateExpenseProfile, types.String do
	    description "field to update expense profile"
	    argument :funds, types.Float
		argument :starts_at_day, types.Int
		argument :can_alert, types.Boolean

	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].update_expense_profile(args.to_h.with_indifferent_access)
	    }
	  end

	end
end
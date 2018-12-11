module Mutations

	SharedCycleMutation = GraphQL::ObjectType.define do
	  name 'SharedCycleMutation'

	  field :createSharedCycle, types.String do
	    description "field to create a new shared cycle"
        argument :title, !types.String
	    argument :description, types.String
	    argument :participants, !types[Types::Input::ParticipantsInputType]
	    
	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].create_shared_cycle(args.to_h.with_indifferent_access)
	    }
	  end

	  field :createSharedExpense, types.String do
	    description "field to create a new shared recoverable expense"
        argument :cycle_id, !types.Int
        argument :type, !types.String
	    argument :description, types.String
	    argument :paid_by, !Types::Input::ParticipantsInputType
	    argument :participants, !types[Types::Input::ParticipantsInputType]
		argument :shareSplitType, !types.String
	    argument :shareSplit, !types[types.Float]
	    argument :spends, !types.Float

	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].add_shared_expense(args.to_h.with_indifferent_access)
	    }
	  end

	  field :updateSharedExpense, types.String do
	    description "field to update a shared pending expense"
        argument :expense_id, !types.Int
        argument :spend, !types.Float
	    
	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].update_shared_expense(args.to_h.with_indifferent_access)
	    }
	  end

	  field :deleteSharedExpense, types.String do
	    description "field to delete a shared expense"
        argument :expense_id, !types.Int

	    resolve ->(obj, args, ctx) {
	      ctx[:current_user].delete_shared_expense(args.to_h.with_indifferent_access)
	    }
	  end

	end
end
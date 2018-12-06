module Types
	class MutationType < Types::BaseObject
	    MutationType = GraphQL::ObjectType.new.tap do |root_type|
	    root_type.name = 'Mutation'
	    root_type.description = 'The mutation root'
	    root_type.interfaces = [
	    	# Add interfaces here 
	    ]
	    root_type.fields = Util::FieldCombiner.combine([
			# Add types here
	    ])
	end
end

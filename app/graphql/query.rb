Query = GraphQL::ObjectType.new.tap do |root_type|
    root_type.name = 'Query'
    root_type.description = 'The query root'
    root_type.interfaces = [
        # Add interfaces here
    ]
    root_type.fields = Util::FieldCombiner.combine([
        # Add types here
        Queries::MonthlyCycleQuery,
        Queries::SharedCycleQuery,
        Queries::UserQuery,
    ])
end

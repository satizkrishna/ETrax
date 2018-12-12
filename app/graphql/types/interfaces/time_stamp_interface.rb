module Types
  module Interfaces
    TimeStampInterface = GraphQL::InterfaceType.define do
      name "TimeStamp"
      description "TimeStamp Interface"

      field :updated_at do
        type types.String

        resolve -> (obj, args, ctx) {
          obj.updated_at.strftime("%a #{obj.updated_at.day.ordinalize}.")
        }
      end
      field :created_at do
        type types.String

        resolve -> (obj, args, ctx) {
          obj.created_at.strftime("%a #{obj.created_at.day.ordinalize}.")
        }
      end
    end
  end
end
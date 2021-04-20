module Types
  class QueryType < Types::BaseObject

    field :orders, resolver: Queries::Orders
  end
end

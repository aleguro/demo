module Queries
  class Orders < Queries::BaseQuery
    type [Types::Models::OrderType], null: false
    description 'Get orders'

    def single(**args)
      Order.where(id: args[:id])
    end

    def multiple(**args)

    	Order.all
    end  
  end
end
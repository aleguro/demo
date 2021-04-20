module Types
  class MutationType < Types::BaseObject
 
 		field :create_order, resolver: Mutations::Orders::CreateOrder
  end
end

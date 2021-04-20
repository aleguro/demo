module Types::Models
  class OrderType < Types::BaseObject
	  field :id, ID, null: true
	  field :title, String, null: true
	  field :body, String, null: true
	  field :idd, Integer, null: true
	  field :items, [Types::Models::ItemType], null: true   	
	end
end
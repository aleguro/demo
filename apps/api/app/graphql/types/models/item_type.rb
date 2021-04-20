module Types::Models
  class ItemType < Types::BaseObject
	  field :id, ID, null: true
  	field :name, String, null: true
  	field :cost, Float, null: true
		field :quantity, Integer, null: true
	end
end
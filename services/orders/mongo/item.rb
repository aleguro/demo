class Item
  include Mongoid::Document

  field :name, type: String
  field :cost, type: Float
	field :quantity, type: Integer

  embedded_in :order
end
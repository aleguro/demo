class Order
  include Mongoid::Document
	include Mongoid::Attributes::Dynamic

  field :title, type: String
  field :body, type: String
  field :idd, type: Integer

  embeds_many :items
end
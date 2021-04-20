class Order
  include Mongoid::Document

  field :title, type: String
  field :body, type: String
  field :idd, type: Integer

  embeds_many :items
end
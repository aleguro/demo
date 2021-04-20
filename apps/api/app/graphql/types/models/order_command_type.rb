module Types::Models
  class OrderCommandType < Types::BaseObject
	  field :id, ID, null: false
	  field :command_name, String, null: true
	  field :order_id, Integer, null: true
	  field :payload , GraphQL::Types::JSON, null: true
	  field :created_at, GraphQL::Types::ISO8601DateTime, null: true
	  field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
	end
end
require 'redis'
require_relative '../mongo/order'
require_relative '../mongo/item'

module Commands
	class CreateOrder

		# payload
		# =>
			# {
			# 	"idd": 1, 
			# 	"body": "This is the body", 
			# 	"items": [ 
			# 		{ "cost": 10.0, 
			#   		"name": "Item #1", 
			#   		"quantity": 2
		  #  		}], 
		  #  	"title": "Testing mutation"
		  # }
		def initialize(command)

			@order 		= Order.new
			@order_id = command.order_id
			@payload	= command.payload
		end

		# Applies command logic to data models.
		def apply

			p "----------------- CREATING MONGO record !"

			@order.title = @payload['title']
			@order.body  = @payload['body']
			@order.idd   = @order_id

			@payload['items'].each do |item|

				@order.items << Item.new(
					name: item['name'],
					cost: item['cost'],
					quantity: item['quantity'] 
				)
			end

			@order.save!
			notify @order.id
		end

		def notify(id)

			connection = Redis.new(host: 'redis', port: 6379)
			connection.publish 'orders_topic', "{\"channel\": \"A\", \"message\": \"#{id}\" }"
		end
	end
end	
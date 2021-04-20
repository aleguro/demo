	module Mutations::Orders
	class CreateOrder < ::Mutations::BaseMutation
		argument :title, type: String, required: true
		argument :body, type: String, required: true
		argument :items, [Types::Input::LineItemInputType], required: true

		type Types::Models::OrderCommandType

		def resolve(**args)

			order_command = create_order(args)

			push_order(order_command)

			order_command
		end

		private

		# Creates an order 
		def create_order(**args)

			order = Domain::Order.new(sanitize(args))

			if order.valid?

				order_command = OrderCommand.new(build_args(order))
				order_command.save
				return order_command
			else

				raise "Failed to create order: #{order.errors.full_messages.to_a.join('\n')}"
			end	
		end

		def build_args(order)

			{ command_name: caller, payload: order.to_h }
		end

		# Pushes a notification to AWS-SNS
		# =>
			# awslocal sns publish 
			# --topic-arn arn:aws:sns:eu-west-1:000000000000:order_topic 
			# --message "#{order.id.to_s}"
		def push_order(order_command)

			client = ::Aws::SNS::Client.new(region: 'eu-west-1', 
				credentials: ::Aws::Credentials.new('akid', 'secret'), 
				endpoint: 'http://localstack:4575')

			resp = client.publish({
			  topic_arn: "arn:aws:sns:eu-west-1:000000000000:order_topic",
			  subject: caller,
			  message: order_command.id.to_s
			})

			pp resp
		end 
	end
end	
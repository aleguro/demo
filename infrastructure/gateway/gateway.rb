require 'bundler/setup'
require 'eventmachine'
require 'aws-sdk-sqs'
require 'aws-sdk-sns'

p 'Being of all things'

ENV = {}
ENV['host'] = 'postgresql-master'
ENV['port'] = '5432'

p 'Finish setup env vars'

require 'services/orders/order.rb'

p 'Finish loading'

sqs = Aws::SQS::Client.new(region: 'eu-west-1', 
	credentials: Aws::Credentials.new('akid', 'secret'), 
	endpoint: 'http://localstack:4576')

sns = Aws::SNS::Client.new(region: 'eu-west-1', 
	credentials: Aws::Credentials.new('akid', 'secret'), 
	endpoint: 'http://localstack:4575')

order_queue   	= sqs.create_queue({queue_name: 'order_queue'})
order_topic_arn = sns.create_topic({name: 'order_topic'})

subscription = sns.subscribe({topic_arn: order_topic_arn.topic_arn, 
  protocol: "sqs", 
  endpoint: order_queue.queue_url,  
  return_subscription_arn: true
})

p 'Finish creating queues!'

EM.run do

	p 'Running event machine'

	# Can set periodic timer for different queues
  EM.add_periodic_timer(0.5) do

  	#{ "Records": [
	  	# {:message_id=>"0d2072d4-9023-416d-a79a-c25aa221692f", 
	  	# :receipt_handle=>"0d2072d4-9023-416d-a79a-c25aa221692f#c5d5cacb-2fc5-49df-afd4-aa9d72b844f6", 
	  	# :md5_of_body=>"4a28d21b033fb71e2b3404a5479848e0", 
	  	# :body=>"Battery azis", 
	  	# :attributes=>{}, 
	  	# :md5_of_message_attributes=>nil, 
	  	# :message_attributes=>{}}
	  # ] }	
  	resp = sqs.receive_message(queue_url: 'http://localstack:4566/queue/order_queue', max_number_of_messages: 10)

		resp.messages.each do |m|

			messages = ({'Records' => [m]})
	
			pp messages

			main(event: messages, context: {})

			sqs.delete_message({queue_url: "http://localstack:4566/queue/order_queue", receipt_handle: m[:receipt_handle]})		
		end
  end
end

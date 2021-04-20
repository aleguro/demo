p '1 bundler/setup'
require 'bundler/setup'
p '2 json'
require 'json'
p '3 logger'
require 'logger'
p '4 mongoid'
require 'mongoid'
p '5 app'
require_relative 'commands/router'

# Order.handler
def main(event:, context:)
	begin

		p 'Conecting to mongo'
		Mongoid.configure.log_level = :fatal
		Mongoid.load!('mongoid.yml',:development)

		p '------------------------------------------------------------------'
		p 'Order.main function called again and again'
		p '------------------------------------------------------------------'

		event['Records'].each do |record|

			body = JSON.parse(record['body'])

			p "BODY: 		 #{body}"
			p "ORDER ID: #{body['Message']}"
			p "Command:  #{body['Subject']}"

			command    = body['Subject']
			command_id = body['Message'].to_i

			Commands::Router::execute command_id
		end

		return { statusCode: 200 }.to_json
	rescue StandardError => e

		puts e.message  
  	puts e.backtrace.inspect  
	end

	{ statusCode: 500, message: 'Unexpected error!' }.to_json  
end
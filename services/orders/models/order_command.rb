require 'bundler/setup'
require 'pg'
require 'active_record'

begin

	p 'Connecting to postgres'
	p "ENV HOST: #{ENV['host']}"
	p "ENV PORT: #{ENV['port']}"

	ActiveRecord::Base.establish_connection(
	  :adapter  => "postgresql",
	  :host     => ENV['host'],
	  :username => 'postgres',
	  :password => 'postgres',
	  :database => 'demo',
	  :port	    => ENV['port']
	)
rescue StandardError => e  
	puts e.message  
  puts e.backtrace.inspect  
end	

class OrderCommand < ActiveRecord::Base
end
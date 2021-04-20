require_relative 'create_order'
require_relative '../models/order_command'

module Commands
	class Router

	  # Replay a chain of commands for a given order_id
		def self.replay(order_id)

			order_commands = OrderCommand.where(order_id: order_id)

			order_commands.each do |order_command|

				command = "Commands::#{order_command.command_name.camelize(:upper)}".constantize.new(command)
				command.apply
			end
		end

		# Applies one command
		def self.execute(command_id)

			order_command = OrderCommand.find(command_id)

			begin
				command = "Commands::#{order_command.command_name.camelize(:upper)}".constantize.new(order_command) 
				command.apply

			rescue StandardError => e

				pp e.message
				pp e.backtrace.join('\n')		
			end	
		end
	end
end	
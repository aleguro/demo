class DemoSchema < GraphQL::Schema
	rescue_from(StandardError) do |message|

    p "Error: #{message.message}*\n#{message.backtrace.join('\n')}"
    GraphQL::ExecutionError.new(message, extensions: {code: 'ERROR'})
  end

  mutation(Types::MutationType)
  query(Types::QueryType)
  #subscription(Types::SubscriptionType)

	use GraphQL::Batch
  use GraphQL::Execution::Interpreter
  use GraphQL::Execution::Errors
  use GraphQL::Analysis::AST

  use GraphQL::Pagination::Connections
end
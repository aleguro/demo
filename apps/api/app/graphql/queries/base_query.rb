module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    argument :id, ID, required: false
    argument :sort, String, required: false

    def self.authorized?(object, context)

      super && true
    end

    def resolve(**args)

      if args.dig :id

        single **args
      else

        sort(multiple(**args), **args)
      end
    end

    def sort(relation, **args)

      return relation if relation.is_a? Array

      relation.order args.dig :sort || :id
    end
  end
end
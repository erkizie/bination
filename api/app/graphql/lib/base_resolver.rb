module Lib
  class BaseResolver < GraphQL::Schema::Resolver

    def generate_response(result)
      if result.success?
        result[:model]
      else
        GraphQL::ExecutionError.new(Lib::Service::ErrorsConverter.call(result[:errors]))
      end
    end

    def self.authorized?(object, context)
      return true unless auth_required?

      return true if context[:current_user].present?
      raise GraphQL::ExecutionError, "User not signed in"
    end

    private

    def self.auth_required?
      raise "Please, implement method #{__method__} in your class"
    end

  end
end

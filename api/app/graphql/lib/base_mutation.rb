module Lib
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Lib::BaseArgument
    field_class Lib::BaseField
    input_object_class Lib::BaseInputObject
    object_class Lib::BaseObject

    def generate_response(result)
      if result.success?
        model_name = result[:model].class.to_s.underscore
        { model_name => result[:model], :errors => [] }
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

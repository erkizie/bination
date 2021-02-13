module Lib
  class BaseField < GraphQL::Schema::Field
    argument_class ::Lib::BaseArgument
  end
end

module Lib
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Lib::BaseArgument
  end
end

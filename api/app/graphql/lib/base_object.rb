module Lib
  class BaseObject < GraphQL::Schema::Object
    field_class Lib::BaseField
  end
end

module Lib
  module BaseInterface
    include GraphQL::Schema::Interface

    field_class Lib::BaseField
  end
end

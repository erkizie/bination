module Lib
  module Objects
    class User < Lib::BaseObject
      description 'A user'

      field :id,                    ID,                                  null:false
      field :username,              String,                              null: true
      field :email,                 String,                              null: false

    end
  end
end

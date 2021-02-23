module Lib
  module Objects
    class Article < Lib::BaseObject
      description 'Article'

      field :id,                    ID,                                  null:false
      field :title,                 String,                              null: true
      field :body,                  String,                              null: false
      field :description,           String,                              null: false
      field :user_id,               ID,                                  null: false

    end
  end
end

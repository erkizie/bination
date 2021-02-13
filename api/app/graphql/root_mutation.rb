class RootMutation < Lib::BaseObject

  field :sign_up, mutation: ::Users::Mutations::SignUp

end

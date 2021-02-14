class RootMutation < Lib::BaseObject

  field :sign_up, mutation: ::Users::Mutations::SignUp
  field :sign_in, mutation: ::Users::Mutations::SignIn
  field :sign_out, mutation: ::Users::Mutations::SignOut

end

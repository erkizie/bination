class RootMutation < Lib::BaseObject

  field :sign_up, mutation: ::Users::Mutations::SignUp
  field :sign_in, mutation: ::Users::Mutations::SignIn
  field :sign_out, mutation: ::Users::Mutations::SignOut
  field :update_user, mutation: ::Users::Mutations::UpdateUser

  field :create_article, mutation: ::Articles::Mutations::CreateArticle

end

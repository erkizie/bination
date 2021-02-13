module Users::Mutations
  class SignUp < ::Lib::BaseMutation

    argument :email, String, required: true
    argument :password, String, required: true
    argument :username, String, required: true

    field :user,      Lib::Objects::User,   null: true
    field :errors,   [Lib::Objects::Error],    null: true

    def ready?(**args)
      # To check policy, permissions, etc
      true
    end

    def resolve(args)
      result = ::Core::User::Operations::SignUp.(params: args)
      generate_response(result)
    end

    private

    def self.auth_required?
      false
    end
  end
end

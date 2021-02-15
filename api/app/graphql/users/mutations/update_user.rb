module Users::Mutations
  class UpdateUser < ::Lib::BaseMutation

    argument :password, String, required: false

    field :user,      Lib::Objects::User,      null: true
    field :errors,   [Lib::Objects::Error],    null: true

    def ready?(**args)
      # To check policy, permissions, etc
      true
    end

    def resolve(args)
      result = ::Core::User::Operations::Update.(params: args, current_user: context[:current_user])
      generate_response(result)
    end

    private

    def self.auth_required?
      true
    end
  end
end

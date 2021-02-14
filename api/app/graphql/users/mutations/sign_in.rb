module Users::Mutations
  class SignIn < ::Lib::BaseMutation

    argument :username, String, required: true
    argument :password, String, required: true

    field :token,    String,       null: true
    field :user,     Lib::Objects::User,       null: true
    field :errors,   [Lib::Objects::Error],    null: true

    def ready?(**args)
      # To check policy, permissions, etc
      true
    end

    def resolve(args)
      result = ::Core::User::Operations::SignIn.(args)

      if result.success?
        { token: result[:token], user: result[:model], errors: [] }
      else
        GraphQL::ExecutionError.new(Lib::Service::ErrorsConverter.call(result[:errors]))
      end
    end

    private

    def self.auth_required?
      false
    end
  end
end

module Users::Mutations
  class SignOut < ::Lib::BaseMutation
    #
    field :result,    Boolean,      null: true
    field :errors,   [Lib::Objects::Error],    null: true

    def ready?(**args)
      # To check policy, permissions, etc
      true
    end

    def resolve
      ::Core::User::Operations::SignOut.(current_user: context[:current_user])
      { result: true, errors: [] }
    end

    private

    def self.auth_required?
      true
    end
  end
end

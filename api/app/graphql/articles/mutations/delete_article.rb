module Articles::Mutations
  class DeleteArticle < ::Lib::BaseMutation

    argument :id, ID, required: true

    field :article,  Lib::Objects::Article,   null: true
    field :errors,   [Lib::Objects::Error],    null: true

    def ready?(**args)
      # To check policy, permissions, etc
      unless ::Article.find(args[:id].to_i).user_id == context[:current_user].id
        raise GraphQL::ExecutionError, "Only owner can delete"
      end
      true
    end

    def resolve(**args)
      result = ::Core::Article::Operations::Delete.(params: params(args))
      generate_response(result)
    end

    private

    def params(args)
      args.merge(user_id: context[:current_user].id)
    end

    def self.auth_required?
      true
    end
  end
end

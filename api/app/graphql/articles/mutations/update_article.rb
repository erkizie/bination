module Articles::Mutations
  class UpdateArticle < ::Lib::BaseMutation

    argument :id, ID,      required: false
    argument :title,       String, required: false
    argument :body,        String, required: false
    argument :description, String, required: false

    field :article,  Lib::Objects::Article,   null: true
    field :errors,   [Lib::Objects::Error],    null: true

    def ready?(**args)
      # To check policy, permissions, etc
      unless ::Article.find(args[:id].to_i).user_id == context[:current_user].id
        raise GraphQL::ExecutionError, "Only owner can update"
      end
      true
    end

    def resolve(**args)
      result = ::Core::Article::Operations::Update.(params: params(args))
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

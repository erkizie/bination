module Articles::Mutations
  class CreateArticle < ::Lib::BaseMutation

    argument :title,       String, required: true
    argument :body,        String, required: true
    argument :description, String, required: true

    field :article, Lib::Objects::Article,   null: true
    field :errors,   [Lib::Objects::Error],    null: true

    def ready?(**args)
      # To check policy, permissions, etc
      true
    end

    def resolve(**args)
      result = ::Core::Article::Operations::Create.(params: params(args))
      generate_response(result)
    end

    private

    def params(args)
      {
        title: args[:title],
        body: args[:body],
        description: args[:description],
        user_id: context[:current_user].id
      }
    end

    def self.auth_required?
      true
    end
  end
end

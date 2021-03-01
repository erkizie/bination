module Articles::Resolvers
  class ListUserArticles < ::Lib::BaseResolver

    type [Lib::Objects::Article], null: false

    def resolve
      result = ::Core::Article::Operations::UserArticles.call(user: context[:current_user])
      generate_response(result)
    end

    private

    def self.auth_required?
      true
    end
  end
end

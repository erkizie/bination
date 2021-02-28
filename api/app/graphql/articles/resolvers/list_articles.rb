module Articles::Resolvers
  class ListArticles < ::Lib::BaseResolver

    type [Lib::Objects::Article], null: false

    def resolve
      result = ::Core::Article::Operations::Index.call
      generate_response(result)
    end

    private

    def self.auth_required?
      true
    end
  end
end

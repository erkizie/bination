module Articles::Resolvers
  class GetArticle < ::Lib::BaseResolver

    type Lib::Objects::Article, null: false

    argument :id, ID, required: true

    def resolve(id:)
      result = ::Core::Article::Operations::Get.call(params: {id: id})
      generate_response(result)
    end

    private

    def self.auth_required?
      true
    end
  end
end

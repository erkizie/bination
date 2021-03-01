module Core
  module Article
    module Operations
      class UserArticles < Trailblazer::Operation

        step :list_articles

        def list_articles(ctx, *)
          ctx[:model] = ::Article.where(user_id: ctx[:user].id)
        end
      end
    end
  end
end

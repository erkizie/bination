module Core
  module Article
    module Operations
      class Index < Trailblazer::Operation

        step :list_all

        def list_all(ctx, *)
          ctx[:model] = ::Article.all
        end
      end
    end
  end
end

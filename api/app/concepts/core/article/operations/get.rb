require_relative '../../common/operation_helpers'
module Core
  module Article
    module Operations
      class Get < Trailblazer::Operation
        include OperationHelpers

        step :model!, Output(:failure) => End(:not_found)

        def model!(ctx, *)
          ctx[:model] = ::Article.find_by(id: ctx[:params][:id])
          ctx[:model].present? ? ctx[:model] : add_error(ctx, :article, 'Article not found.')
        end
      end
    end
  end
end

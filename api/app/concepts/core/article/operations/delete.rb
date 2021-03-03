require_relative '../../common/operation_helpers'
module Core
  module Article
    module Operations
      class Delete < Trailblazer::Operation
        include OperationHelpers

        step :model!, Output(:failure) => End(:not_found)
        step :delete!

        def model!(ctx, *)
          ctx[:model] = ::Article.find_by(id: ctx[:params][:id])
          ctx[:model].present? ? ctx[:model] : add_error(ctx, :article, 'Article not found.')
        end

        def delete!(ctx, params:, **)
          ctx['model'].destroy
        end
      end
    end
  end
end

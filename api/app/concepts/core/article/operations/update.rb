require_relative '../../common/operation_helpers'
module Core
  module Article
    module Operations
      class Update < Trailblazer::Operation
        include OperationHelpers

        class Form < Reform::Form
          property :title
          property :body
          property :description

          validates :title, :body, :description, presence: true
        end

        step :model!
        step :validate
        step :save

        def model!(ctx, *)
          ctx[:model] = ::Article.find_by(id: ctx[:params][:id])
          ctx[:model].present? ? ctx[:model] : add_error(ctx, :article, 'Article not found.')
        end

        def validate(ctx, *)
          ctx[:form]  = Form.new(ctx[:model])
          ctx[:form].validate(ctx[:params])
          handle_validation_errors(ctx)
        end

        def save(ctx, *)
          ctx[:form].save
        end
      end
    end
  end
end

require_relative '../../common/operation_helpers'
module Core
  module Article
    module Operations
      class Create < Trailblazer::Operation
        include OperationHelpers

        class Form < Reform::Form
          property :title
          property :body
          property :description
          property :user_id

          validates :title, :body, :description, :user_id, presence: true
        end

        step :validate
        step :save

        def validate(ctx, *)
          ctx[:model] = ::Article.new
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

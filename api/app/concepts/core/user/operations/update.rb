require_relative '../../common/operation_helpers'
module Core
  module User
    module Operations
      class Update < Trailblazer::Operation
        include OperationHelpers

        class Form < Reform::Form
          property :password

          validates :password, presence: true
          validates :password, length: { minimum: 6 }
        end

        step :validate
        step :save

        def validate(ctx, current_user:, **)
          ctx[:model] = current_user
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

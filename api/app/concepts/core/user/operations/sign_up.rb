require_relative '../../common/operation_helpers'
module Core
  module User
    module Operations
      class SignUp < Trailblazer::Operation
        include OperationHelpers

        class Form < Reform::Form
          property :username
          property :email
          property :password

          validates :username, :email, :password, presence: true
          validates :password, length: { minimum: 8 }
          validates_uniqueness_of :email
          validates_uniqueness_of :username
        end

        step :validate
        step :save

        def validate(ctx, *)
          ctx[:model] = ::User.new
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

require_relative '../../common/operation_helpers'
module Core
  module User
    module Operations
      class SignOut < Trailblazer::Operation
        include OperationHelpers

        step :model!, Output(:failure) => End(:not_found)
        step :reset_token

        def model!(ctx, params, *)
          ctx[:model] = params[:current_user]
          ctx[:model].present? ? ctx[:model] : add_error(ctx, :user, 'User not found.')
        end

        def reset_token(ctx, *)
          ctx[:model].update(jti: SecureRandom.uuid)
        end
      end
    end
  end
end

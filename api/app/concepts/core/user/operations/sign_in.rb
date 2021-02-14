require_relative '../../common/operation_helpers'
require_relative '../../../../../lib/services/auth_token'
module Core
  module User
    module Operations
      class SignIn < Trailblazer::Operation
        include OperationHelpers

        step :model!, Output(:failure) => End(:not_found)
        step :validate
        step :token

        def model!(ctx, params, *)
          ctx[:model] = ::User.find_for_database_authentication(username: params[:username])
          ctx[:model].present? ? ctx[:model] : add_error(ctx, :user, 'User not found.')
        end

        def validate(ctx, params, *)
          ctx[:model].valid_password?(params[:password]) ? ctx[:model] : add_error(ctx, :user, 'Invalid password')
        end

        def token(ctx, *)
          ctx[:token] = AuthToken.generate(ctx[:model])
        end
      end
    end
  end
end

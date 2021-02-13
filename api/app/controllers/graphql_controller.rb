class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    result = ::ExecuteSchema.(params: request.params, current_user: current_user)
    render json: result[:model]
  rescue StandardError => error
    raise error unless Rails.env.development?
    handle_error_in_development error
  end

  private

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token
  class MissingToken < StandardError; end
  class Unauthorized < StandardError; end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing_handler
  rescue_from MissingToken, with: :missing_token_handler
  rescue_from Unauthorized, with: :unauthorized_handler
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_handler

  private

  def authenticate_user
    token, _options = token_and_options(request)
    raise MissingToken unless token

    decoded_token = AuthenticationTokenService.decode(token)
    user_data = decoded_token[0].deep_symbolize_keys
    @user = User.find(user_data[:user_id])
  end

  def current_user
    @user ||= authenticate_user
  end

  def parameter_missing_handler(e)
    render status: :unprocessable_entity, json: { error: e.original_message }
  end

  def missing_token_handler
    render status: 400, json: { error: "Missing authorization header" }
  end

  def unauthorized_handler(e)
    render status: :forbidden, json: { error: "This resource does not belong to you" }
  end

  def record_not_found_handler(e)
    render status: :not_found, json: { error: e.to_s }
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token
  include Pagination
  include ApplicationRescuer

  private

  def authenticate_user
    token, _options = token_and_options(request)
    raise MissingToken unless token

    decoded_token = AuthenticationTokenService.decode(token)
    user_data = decoded_token[0].deep_symbolize_keys
    user_data = { data: user_data } unless user_data[:data]
    @current_user = User.find(user_data[:data][:user_id])
  end

  def current_user
    @current_user ||= authenticate_user
  end
end

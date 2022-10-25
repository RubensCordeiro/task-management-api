# frozen_string_literal: true

module AuthenticationsRescuer
  extend ActiveSupport::Concern

  class UserNotFound < StandardError; end
  class AuthenticationError < StandardError; end

  included do
    rescue_from UserNotFound, with: :user_not_found_handler
    rescue_from AuthenticationError, with: :authentication_error_handler
  end

  private

  def user_not_found_handler
    render status: :not_found, json: { error: 'User not found' }
  end

  def authentication_error_handler
    render status: :unauthorized, json: { error: 'Wrong username or password' }
  end
end

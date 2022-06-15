# frozen_string_literal: true

module Api
  module V1
    class AuthenticationsController < UsersController
      class UserNotFound < StandardError; end
      class AuthenticationError < StandardError; end

      rescue_from UserNotFound, with: :user_not_found_handler
      rescue_from AuthenticationError, with: :authentication_error_handler

      def authenticate
        raise UserNotFound unless user
        raise AuthenticationError unless password_valid?

        token = AuthenticationTokenService.encode(data: { user_id: user.id })
        render json: token, status: :created
      end

      private

      def user
        @user ||= User.find_by(username: user_params[:username])
      end

      def password_valid?
        user.authenticate(user_params[:password])
      end

      def user_not_found_handler
        render status: :not_found, json: { error: 'User not found' }
      end

      def authentication_error_handler(_e)
        render status: :unauthorized, json: { error: 'Wrong username or password' }
      end
    end
  end
end

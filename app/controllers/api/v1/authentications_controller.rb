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

        token = AuthenticationTokenService.encode(data: { user_id: user.id, security_salt: random_string(20) })
        render json: { token: token }, status: :created
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

      def authentication_error_handler
        render status: :unauthorized, json: { error: 'Wrong username or password' }
      end

      def random_string(length)
        chars  = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
        (1..length).map do
          chars[rand(chars.length)]
        end.join
      end
    end
  end
end

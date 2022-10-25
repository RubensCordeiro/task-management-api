# frozen_string_literal: true

module Api
  module V1
    class AuthenticationsController < UsersController
      include AuthenticationsRescuer

      def authenticate
        raise UserNotFound unless user
        raise AuthenticationError unless password_valid?

        token = AuthenticationTokenService.encode(data: { user_id: user.id, security_salt: random_string(20) })
        render json: { token: }, status: :created
      end

      private

      def user
        @user ||= User.find_by(username: user_params[:username])
      end

      def password_valid?
        user.authenticate(user_params[:password])
      end

      def random_string(length)
        chars = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
        (1..length).map do
          chars[rand(chars.length)]
        end.join
      end
    end
  end
end

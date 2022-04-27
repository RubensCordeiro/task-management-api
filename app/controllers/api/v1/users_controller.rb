module Api
  module V1
    class UsersController < Base

      rescue_from ActionController::ParameterMissing, with: :parameter_missing_handler

      def create
        response = repository.create(user_params)
        render json: response, status: :created
      end

      def update
        response = repository.update(user_id, user_params)
        render json: response
      end

      def destroy
        response = repository.destroy(user_id)
        render json: response
      end

      private

      def repository
        Repositories::Users.new
      end

      def user_params
        {
          username: params.require(:username),
          password: params.require(:password)
        }
      end

      def user_id
        params.require(:id)
      end

      def parameter_missing_handler(e)
        render status: :bad_request, json: {error: e.original_message}
      end

    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      class EmailAlreadyRegistered < StandardError; end
      class InvalidParameterError < StandardError; end

      skip_before_action only: [:email_exists?]
      before_action only: %i[update destroy] do
        authenticate_user
        check_record_ownership(user_id)
      end

      rescue_from InvalidParameterError, with: :invalid_parameter_handler

      def create
        @response = repository.create(user_params)
        raise InvalidParameterError if @response.errors.size.positive?

        render status: :created
      end

      def update
        response = repository.update(user_id, user_params)
        render json: response
      end

      def destroy
        response = repository.destroy(user_id)
        render json: response
      end

      def email_exists?
        response = repository.find_email(params.fetch(:email))
        render json: response
      end

      private

      def invalid_parameter_handler
        render status: :bad_request, json: { error: @response.errors.full_messages }
      end

      def repository
        Repositories::Users.new
      end

      def user_params
        {
          username: params.require(:username),
          password: params.require(:password),
          email: params[:email]
        }
      end

      def user_id
        params.require(:id)
      end

      def check_record_ownership(user_id)
        raise Forbidden unless current_user.id.to_i == user_id.to_i
      end
    end
  end
end

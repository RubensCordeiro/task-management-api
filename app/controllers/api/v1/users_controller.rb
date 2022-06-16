# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      class EmailAlreadyRegistered < StandardError; end

      skip_before_action only: [:email_exists?]
      before_action only: %i[update destroy] do
        authenticate_user
        check_record_ownership(user_id)
      end

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

      def email_exists?
        response = repository.find_email(params.fetch(:email))
        render json: response
      end

      private

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

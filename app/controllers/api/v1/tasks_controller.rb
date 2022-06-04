module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_user
      before_action :check_task_ownership, only: [:show, :update, :destroy]

      def index
        response = repository.index(current_user&.id, filter_param) # To prevent nil method error
        render json: response
      end

      def show
        response = repository.show(task_id)
        render json: response
      end

      def create
        raise ActionController::ParameterMissing.new(params: ["title", "due_date"]) unless mandatory_params_present?

        response = repository.create(task_params.merge(user_id: current_user.id))
        render json: response
      end

      def update
        response = repository.update(task_id, task_params)
        render json: response
      end

      def destroy
        response = repository.destroy(task_id)
        render json: response
      end

      private

      def repository
        Repositories::Tasks.new
      end

      def task_id
        params.require(:id)
      end

      def task_params
        request_params = params.require(:task).permit(:title, :summary, :description, :due_date, :priority, :urgent,
                                                      :finished)
        request_params = request_params.select do |param, value|
          value.present? && [nil, 'null', '', ""].exclude?(value)
        end
      end

      def mandatory_params_present?
        task_params.include?(:due_date) && task_params.include?(:title)
      end

      def check_task_ownership
        raise Forbidden unless Task.find(task_id).user_id == current_user&.id
      end

      def filter_param
        return nil if ['all', nil, ''].include?(params[:filter] )
        return params[:filter] if ['urgent', 'late', 'today', 'tomorrow', 'next_week'].include?(params[:filter])
      end

    end
  end
end

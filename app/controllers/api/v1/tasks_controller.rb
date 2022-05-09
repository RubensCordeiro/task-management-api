module Api
  module V1
    class TasksController < ApplicationController
      before_action do
        authenticate_user
      end

      def index
        repository.index(current_user&.id) # To prevent nil method error
      end

      def show
        task = repository.show(task_id)
        raise Unauthorized unless task.user.id == current_user&.id
        task
      end

      private

      def repository
        Repositories::Tasks.new
      end

      def task_id
        params.require(:id)
      end
    end
  end
end

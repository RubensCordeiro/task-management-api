module Repositories
  class Tasks < Base
    def index(user_id, filter_param=nil)
      tasks = User.find(user_id).tasks 
      return tasks unless filter_param.present?
      return tasks.where_urgent if filter_param == 'urgent'
      return tasks.where_late if filter_param == 'late'
      return tasks.where_today if filter_param == 'today'
      return tasks.where_tomorrow if filter_param == 'tomorrow'
      return tasks.where_next_week if filter_param == 'next_week'
    end

    private

    def entity
      Task
    end
  end
end

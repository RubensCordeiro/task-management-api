module Repositories
  class Tasks < Base
    def index(user_id)
      User.find(user_id).tasks
    end

    private

    def entity
      Task
    end
  end
end

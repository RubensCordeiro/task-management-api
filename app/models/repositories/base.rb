module Repositories
  class Base
    def index
      entity_dataset
    end

    def show(id)
      begin
        entity.find(id)
      rescue ActiveRecord::RecordNotFound
        return { error: "#{entity.to_s} not found" }
      end
    end

    def create(attributes)
      entity.create(attributes)
    end

    def update(id, attributes)
      begin
        entity.find(id)
      rescue ActiveRecord::RecordNotFound
        return { error: "#{entity.to_s} not found" }
      else
        entity.find(id).update(attributes)
      end
    end

    def destroy(id)
      begin
        entity.find(id)
      rescue ActiveRecord::RecordNotFound
        return { error: "#{entity.to_s} not found" }
      else
        entity.destroy(id)
      end
    end

    private

    def entity
      raise NotImplementedError
    end

    def entity_dataset
      entity.all
    end
  end
end

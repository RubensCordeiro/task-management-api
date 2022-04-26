module Repositories
  class Base
    def index
      entity_dataset
    end

    def show(id)
      entity.find(id)
    end

    def create(attributes)
      entity.create(attributes)
    end

    def update(id, attributes)
      entity.find(id).update(attributes)
    end

    def destroy(id)
      entity.destroy(id)
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

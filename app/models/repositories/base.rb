# frozen_string_literal: true

module Repositories
  class Base
    def index
      entity_dataset
    end

    def show(id)
      entity.find(id)
    rescue ActiveRecord::RecordNotFound
      { error: "#{entity} not found" }
    end

    def create(attributes)
      entity.create(attributes)
    end

    def update(id, attributes)
      entity.find(id)
    rescue ActiveRecord::RecordNotFound
      { error: "#{entity} not found" }
    else
      entity.find(id).update(attributes)
    end

    def destroy(id)
      entity.find(id)
    rescue ActiveRecord::RecordNotFound
      { error: "#{entity} not found" }
    else
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

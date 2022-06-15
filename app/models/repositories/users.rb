# frozen_string_literal: true

module Repositories
  class Users < Base
    def find_email(email)
      entity.find_by(email: email).present?
    end

    private

    def entity
      User
    end
  end
end

# frozen_string_literal: true

module Repositories
  class Users < Base
    def find_email(email)
      formatted_email = email.gsub('-£', '.')
      entity.where(email: formatted_email).present?
    end

    private

    def entity
      User
    end
  end
end

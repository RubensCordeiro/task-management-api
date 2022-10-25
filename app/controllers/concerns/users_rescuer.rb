# frozen_string_literal: true

module UsersRescuer
  extend ActiveSupport::Concern

  class EmailAlreadyRegistered < StandardError; end
  class InvalidParameterError < StandardError; end

  included do
    rescue_from InvalidParameterError, with: :invalid_parameter_handler
  end

  private

  def invalid_parameter_handler
    render status: :bad_request, json: { error: @response.errors.full_messages }
  end
end

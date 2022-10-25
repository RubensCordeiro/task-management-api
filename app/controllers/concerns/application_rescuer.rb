# frozen_string_literal: true

# Rescuer for application controller errors

module ApplicationRescuer
  extend ActiveSupport::Concern

  class MissingToken < StandardError; end
  class Forbidden < StandardError; end

  included do
    rescue_from ActionController::ParameterMissing, with: :parameter_missing_handler
    rescue_from MissingToken, with: :missing_token_handler
    rescue_from Forbidden, with: :forbidden_handler
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_handler
  end

  private

  def parameter_missing_handler(error)
    render status: :unprocessable_entity, json: { error: error.original_message }
  end

  def missing_token_handler
    render status: :bad_request, json: { error: 'Missing authorization header' }
  end

  def forbidden_handler
    render status: :forbidden, json: { error: 'This resource does not belong to you' }
  end

  def record_not_found_handler(error)
    render status: :not_found, json: { error: error.to_s }
  end
end

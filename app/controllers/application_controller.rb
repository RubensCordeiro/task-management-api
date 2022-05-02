class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :parameter_missing_handler

  private

  def parameter_missing_handler(e)
    render status: :unprocessable_entity, json: { error: e.original_message }
  end
end

class ApplicationController < ActionController::API
  rescue_from NoMethodError::undef_method, with: :render_bad_input_response
  rescue_from JSON::ParserError, with: :render_invalid_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  def render_invalid_response(exception)
    render json: ErrorSerializer.new(exception.message).invalid_request, status: :not_found
  end

  def render_bad_input_response
    render json: ErrorSerializer.new("Invalid input").invalid_request, status: :not_found
  end
end

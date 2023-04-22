class ApplicationController < ActionController::API
  rescue_from NoMethodError::undef_method, with: :render_bad_location_response

  def render_invalid_response(exception)
    render json: ErrorSerializer.new(exception.message).invalid_request, status: :not_found
  end

  def render_bad_location_response
    render json: ErrorSerializer.new("Invalid location params").invalid_request, status: :not_found
  end
end

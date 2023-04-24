class Api::V1::SalariesController < ApplicationController

  def index
    salaries = SalariesFacade.new(params[:destination]).create_salaries_object
    render json: SalariesSerializer.new(salaries)
  end

end
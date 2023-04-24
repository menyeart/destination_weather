class SalariesFacade

  def initialize(location)
    @location = location
    @location_service ||= LocationService.new(location).convert_location
    @salaries ||= TeleportService.new(location).get_salary_info
    @current_weather ||= WeatherService.new(extract_location).current_weather
  end

  def parse_salaries
    salary_positions = [15, 16, 32, 41, 45, 46, 51,]
    salaries = []
    salary_positions.each do |salary|
      hash = Hash.new(nil)
      hash["title"] = @salaries["salaries"][salary]["job"]["title"]
      hash["min"] = @salaries["salaries"][salary]["salary_percentiles"]["percentile_25"]
      hash["max"] = @salaries["salaries"][salary]["salary_percentiles"]["percentile_75"]
      salaries << hash
    end
    salaries
  end

  def extract_location
    location =  @location_service[:results].first[:locations].first[:latLng]
    loc_string = "#{location[:lat]}, #{location[:lng]}"
    loc_string
  end

  def get_weather_forecast
    weather = Hash.new(nil)
    binding.pry
    weather[:summary] = @current_weather[:current][:condition][:text]
    weather[:temperature] = @current_weather[:current][:temp_f]
    weather
  end

  def create_salaries_object
    Salaries.new(@location, get_weather_forecast, parse_salaries)
  end


end




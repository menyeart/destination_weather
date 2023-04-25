class WeatherFacade
  def initialize(location)
    @location ||= LocationService.new(location).convert_location
    @current_weather ||= WeatherService.new(extract_location).current_weather
    @daily_weather ||= WeatherService.new(extract_location).daily_weather
  end

  def current
    current = Hash.new(nil)
    current[:last_updated] = @current_weather[:current][:last_updated]
    current[:temperature] = @current_weather[:current][:temp_f]
    current[:feels_like] = @current_weather[:current][:feelslike_f]
    current[:humidity] = @current_weather[:current][:humidity]
    current[:uvi] = @current_weather[:current][:uv]
    current[:visibility] = @current_weather[:current][:vis_miles]
    current[:condition] = @current_weather[:current][:condition][:text]
    current[:icon] = @current_weather[:current][:condition][:icon]
    current
  end

  def daily
    @daily_weather[:forecast][:forecastday].map do |day|
      attributes = Hash.new(nil)
      attributes[:date] = day[:date]
      attributes[:sunrise] = day[:astro][:sunrise]
      attributes[:sunset] = day[:astro][:sunset]
      attributes[:max_temp] = day[:day][:maxtemp_f]
      attributes[:min_temp] = day[:day][:mintemp_f]
      attributes[:condition] = day[:day][:condition][:text]
      attributes[:icon] = day[:day][:condition][:icon]
      attributes
    end
  end

  def hourly
    @daily_weather[:forecast][:forecastday].first[:hour].map do |hour|
      attributes = Hash.new(nil)
      attributes[:time] = hour[:time]
      attributes[:temperature] = hour[:temp_f]
      attributes[:conditions] = hour[:condition][:text]
      attributes[:icon] = hour[:condition][:icon]
      attributes
    end
  end

  def extract_location
    location = @location[:results].first[:locations].first[:latLng]
    "#{location[:lat]}, #{location[:lng]}"
  end

  def create_weather_obj
    WeatherForecast.new(current, daily, hourly)
  end
end

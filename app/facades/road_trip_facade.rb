class RoadTripFacade

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @directions = DirectionService.new(@origin, @destination).directions
    @location_service = LocationService.new(@destination).convert_location
    @location = extract_location
    @weather = WeatherService.new(@location).daily_weather
  end

  def get_travel_info
    attributes = Hash.new(nil)
    attributes[:time] = @directions[:route][:time]
    attributes[:formattedTime] = @directions[:route][:formattedTime]
    attributes[:distance] = @directions[:route][:distance]
    attributes
  end

  def get_days
    time = @directions[:route][:time] + seconds_elapsed_today
    time > 86400 ? (time / 86400).floor : 0
  end

  def get_hours
    time = @directions[:route][:time] + seconds_elapsed_today
    time < 86400 ? (time / 3600).floor : ((time % 86400) / 3600).floor
  end

  def get_destination_weather
    weather = Hash.new(nil)
    weather_info = @weather[:forecast][:forecastday][get_days][:hour][get_hours]
    weather[:datetime] = weather_info[:time]
    weather[:temperature] = weather_info[:temp_f]
    weather[:condition] = weather_info[:condition][:text]
    weather
  end

  def extract_location
    location =  @location_service[:results].first[:locations].first[:latLng]
    loc_string = "#{location[:lat]}, #{location[:lng]}"
    loc_string
  end
  
  def seconds_elapsed_today
    Time.now.strftime('%H').to_f * 3600 + Time.now.strftime('%M').to_f * 60
  end

  def create_road_trip
    RoadTrip.new(@origin, @destination, get_travel_info, get_destination_weather)
  end
end
class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @directions ||= DirectionService.new(@origin, @destination).directions
    @location_service ||= LocationService.new(@destination).convert_location
    @location = extract_location
    @weather ||= WeatherService.new(@location).daily_weather
  end

  def get_travel_info
    attributes = Hash.new(nil)
    if @directions[:info][:messages] == ["We are unable to route with the given locations."]
      attributes[:formattedTime] = "impossible route"
    else
      attributes[:time] = @directions[:route][:time]
      attributes[:formattedTime] = @directions[:route][:formattedTime]
      attributes[:distance] = @directions[:route][:distance]
    end
    attributes
  end

  def get_days
    if @directions[:route][:routeError]
      nil
    else
      time = @directions[:route][:time] + seconds_elapsed_today
      time > 86_400 ? (time / 86_400).floor : 0
    end
  end

  def get_hours
    if @directions[:route][:routeError]
      nil
    else
      time = @directions[:route][:time] + seconds_elapsed_today
      time < 86_400 ? (time / 3600).floor : ((time % 86_400) / 3600).floor
    end
  end

  def get_destination_weather
    weather = Hash.new(nil)
    if get_days.nil? || get_hours == nil?
      weather
    else
      weather_info = @weather[:forecast][:forecastday][get_days][:hour][get_hours]
      weather[:datetime] = weather_info[:time]
      weather[:temperature] = weather_info[:temp_f]
      weather[:condition] = weather_info[:condition][:text]
      weather
    end
  end

  def extract_location
    location = @location_service[:results].first[:locations].first[:latLng]
    "#{location[:lat]}, #{location[:lng]}"
  end

  def seconds_elapsed_today
    Time.now.strftime('%H').to_f * 3600 + Time.now.strftime('%M').to_f * 60
  end

  def create_road_trip
    RoadTrip.new(@origin, @destination, get_travel_info, get_destination_weather)
  end
end

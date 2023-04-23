class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(origin, destination, travel_info, weather_info)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = travel_info[:formattedTime]
    @weather_at_eta = weather_info
  end
end

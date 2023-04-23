class DirectionService 
  def initialize(start, destination)
    @start = start
    @destination = destination
  end

  def conn 
    Faraday.new(url: "https://www.mapquestapi.com/")
  end

  def directions
    get_url("/directions/v2/route?key=#{ENV["MAP_KEY"]}&from=#{@start}&to=#{@destination}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

 
end
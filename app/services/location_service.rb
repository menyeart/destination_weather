class LocationService
  def initialize(location)
    @location = location
  end

  def conn
    Faraday.new(url: "https://www.mapquestapi.com/")
  end

  def convert_location
    get_url("/geocoding/v1/address?key=#{ENV['MAP_KEY']}&inFormat=kvp&outFormat=json&location=#{@location}&thumbMaps=false")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end

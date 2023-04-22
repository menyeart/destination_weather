class WeatherService 
  def current_weather(lat_long)
    get_url("/v1/current.json?aqi=no&key=#{ENV["WEATHER_KEY"]}&q=#{lat_long}")
  end

  def daily_weather(lat_long)
    get_url("/v1/forecast.json?aqi=no&key=#{ENV["WEATHER_KEY"]}&q=#{lat_long}&days=5")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    Faraday.new(url: "http://api.weatherapi.com/")
  end
end
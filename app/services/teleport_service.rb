class TeleportService 
  def initialize(city)
    @city = "slug:#{city.downcase}"
  end

  def get_salary_info
    get_url("urban_areas/#{@city}/salaries")
  end

  def get_urban_areas
    get_url("urban_areas/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body)
  end

  def conn 
    Faraday.new(url: "https://api.teleport.org/api/")
  end
end
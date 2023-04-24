class Salaries
  attr_reader :id, :destination, :forecast, :salaries

  def initialize(city, weather, salaries)
    @id = nil
    @destination = city
    @forecast = weather
    @salaries = salaries
  end
end

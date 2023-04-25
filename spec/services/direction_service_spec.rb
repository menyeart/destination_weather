require "rails_helper"

RSpec.describe DirectionService do
  before(:each) do
    @service = DirectionService.new("Boulder, CO", "Denver, CO")
  end

  describe "exists and has an api call", :vcr do
    it "is a service" do
      expect(@service).to be_a(DirectionService)
    end

    it "has a connection to faraday" do
      expect(@service.conn).to be_a(Faraday::Connection)
    end

    it "takes beginning and end arugments and returns travel time" do
      result = @service.directions

      expect(result).to be_a(Hash)
      expect(result).to have_key(:route)
      expect(result[:route]).to have_key(:time)
      expect(result[:route][:time]).to be_a(Integer)
      expect(result[:route]).to have_key(:formattedTime)
      expect(result[:route][:formattedTime]).to be_a(String)
      expect(result[:route]).to have_key(:distance)
      expect(result[:route][:distance]).to be_a(Float)
    end
  end
end

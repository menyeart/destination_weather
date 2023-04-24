require "rails_helper"

RSpec.describe SalariesFacade do 

  describe "Salaries Facade", :vcr do 
    it "exists" do 
      facade = SalariesFacade.new("Denver")

      expect(facade).to be_a(SalariesFacade)
    end

    it "parses salary info for the selected jobs" do
      salaries = SalariesFacade.new("Denver").parse_salaries_refactor
      keys = ["title", "min", "max"]

      expect(salaries).to be_a(Array)
        salaries.each do |salary|
          expect(salary.keys).to eq(keys)
          expect(salary["title"]).to be_a(String)
          expect(salary["min"]).to be_a(Float)
          expect(salary["max"]).to be_a(Float)
        end
    end

    it "returns a lat/long location from the input city" do
      location = SalariesFacade.new("Denver").extract_location
      
      expect(location).to be_a(String)
      expect(location).to_not eq("Denver")
    end

    it "parses weather data and returns a basic forecast" do
      forecast = SalariesFacade.new("Denver").get_weather_forecast
 
      expect(forecast).to be_a(Hash)
      expect(forecast).to have_key(:summary)
      expect(forecast[:summary]).to be_a(String)
      expect(forecast).to have_key(:temperature)
      expect(forecast[:temperature]).to be_a(Float)
    end

    it "creates a salaries object" do
      forecast = SalariesFacade.new("Denver").create_salaries_object

      binding.pry
      expect(forecast.destination).to eq("Denver")
      expect(forecast.forecast).to be_a(Hash)
      expect(forecast.forecast.keys).to eq([:summary, :temperature])
      expect(forecast.salaries).to be_a(Array)
      forecast.salaries.each do |job|
        expect(job.keys).to eq(["title", "min", "max"])
      end
    end
  end
end
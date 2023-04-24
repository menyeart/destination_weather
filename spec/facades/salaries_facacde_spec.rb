require "rails_helper"

RSpec.describe SalariesFacade do 

  describe "Salaries Facade", :vcr do 
    it "exists" do 
      facade = SalariesFacade.new("Denver")

      expect(facade).to be_a(SalariesFacade)
    end

    it "parses salary info for the selected jobs" do
      salaries = SalariesFacade.new("Denver").parse_salaries
      binding.pry
      expect(trip).to be_a(RoadTrip)
    end
  end
end
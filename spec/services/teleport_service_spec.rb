require "rails_helper"

RSpec.describe TeleportService do 
  before(:each) do 
    @service = TeleportService.new("denver")
  end

  describe "exists and has an api call", :vcr do 
    it "is a service" do 
      expect(@service).to be_a(TeleportService)
    end

    it "has a connection to faraday" do 
      expect(@service.conn).to be_a(Faraday::Connection)
    end

    it "it gets a list of urban areas" do 
      result = @service.get_urban_areas
 
      expect(result).to be_a(Hash)
      expect(result).to have_key("_links")
      expect(result["_links"]).to have_key("ua:item")
      expect(result["_links"]["ua:item"]).to be_a(Array)
      expect(result["_links"]["ua:item"].first).to be_a(Hash)
      expect(result["_links"]["ua:item"].first["name"]).to be_a(String)
      expect(result["_links"]["ua:item"].first["href"]).to be_a(String)
    end

    it "it returns sarlary info for a city" do 
      result = @service.get_salary_info
  
      expect(result).to be_a(Hash)
      expect(result).to have_key("salaries")
      expect(result["salaries"]).to be_a(Array)
      expect(result["salaries"][15]["job"]["title"]).to eq("Data Analyst")
      expect(result["salaries"][16]["job"]["title"]).to eq("Data Scientist")
      expect(result["salaries"][32]["job"]["title"]).to eq("Mobile Developer")
      expect(result["salaries"][41]["job"]["title"]).to eq("QA Engineer")
      expect(result["salaries"][45]["job"]["title"]).to eq("Software Engineer")
      expect(result["salaries"][46]["job"]["title"]).to eq("Systems Administrator")
      expect(result["salaries"][51]["job"]["title"]).to eq("Web Developer")
      expect(result["salaries"][51]["salary_percentiles"]["percentile_25"]).to be_a(Float)
      expect(result["salaries"][51]["salary_percentiles"]["percentile_75"]).to be_a(Float)
    end
  end
end
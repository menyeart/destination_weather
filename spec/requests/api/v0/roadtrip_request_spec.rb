require 'rails_helper'

RSpec.describe 'Roadtrip request spect', type: :request do
  describe '#create', :vcr do
    it 'returns a roadtrip object if inputs are valid' do
      user = User.create!(email: "whatever@example.com", password: 'password', api_key: 'key')
      key = user.api_key
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:start_city, :end_city, :travel_time, :weather_at_eta]
      weather_keys = [:datetime, :temperature, :condition]

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body =  {

        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": key

      }
      post "/api/v0/road_trip", headers:, params: JSON.generate(body)

      trip = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(trip).to have_key(:data)
      expect(trip[:data].keys).to eq(data_keys)
      expect(trip[:data][:attributes].keys).to eq(attribute_keys)
      expect(trip[:data][:attributes][:weather_at_eta].keys).to eq(weather_keys)
    end

    it "returns a roadtrip object with blank weather and 'impossible route' if there is no route between the two points" do
      user = User.create!(email: "whatever@example.com", password: 'password', api_key: 'key')
      key = user.api_key
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:start_city, :end_city, :travel_time, :weather_at_eta]
      weather_keys = [:datetime, :temperature, :condition]

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body =  {

        "origin": "New York City, NY",
        "destination": "London, England",
        "api_key": key

      }
      post "/api/v0/road_trip", headers:, params: JSON.generate(body)

      trip = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(trip).to have_key(:data)
      expect(trip[:data].keys).to eq(data_keys)
      expect(trip[:data][:attributes].keys).to eq(attribute_keys)
      expect(trip[:data][:attributes][:travel_time]).to eq("impossible route")
      expect(trip[:data][:attributes][:weather_at_eta]).to eq({})
    end

    it "returns an error object if an incorrect token is entered" do
      user = User.create!(email: "whatever@example.com", password: 'password', api_key: 'key')
      error_keys = [:status, :title, :detail]

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body =  {

        "origin": "New York City, NY",
        "destination": "London, England",
        "api_key": "nottherightkey"

      }
      post "/api/v0/road_trip", headers:, params: JSON.generate(body)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(error).to have_key(:errors)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:detail]).to eq(["Invalid token"])
    end
  end
end

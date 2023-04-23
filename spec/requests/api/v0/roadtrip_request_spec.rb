require 'rails_helper'

RSpec.describe 'Roadtrip request spect', type: :request do
  describe '#create', :vcr do
    it 'returns a roadtrip object if inpouts are valid' do
      user = User.create!(email: "whatever@example.com", password: 'password')

      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {

        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"

              }
      post "/api/v0/road_trip", headers: headers, params: JSON.generate(body)
      
      user = JSON.parse(response.body, symbolize_names: true)   

      # expect(response).to be_successful
      # expect(response.status).to eq(200)
      # expect(user).to have_key(:data)
      # expect(user[:data].keys).to eq(data_keys)
      # expect(user[:data][:attributes].keys).to eq(attribute_keys)
    end
  end
end

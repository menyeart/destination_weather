require 'rails_helper'

RSpec.describe 'Salaries request spec', type: :request do
  describe '#seach', :vcr do
    it 'returns a salary object if inputs are valid' do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get "/api/v1/salaries?destination=denver", headers: headers, params: JSON.generate(body)
      
      user = JSON.parse(response.body, symbolize_names: true)   

      # expect(response).to be_successful
      # expect(response.status).to eq(200)
      # expect(user).to have_key(:data)
      # expect(user[:data].keys).to eq(data_keys)
      # expect(user[:data][:attributes].keys).to eq(attribute_keys)
    end
  end
end
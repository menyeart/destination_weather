require 'rails_helper'

RSpec.describe 'Salaries request spec', type: :request do
  describe '#seach', :vcr do
    it 'returns a salary object if inputs are valid' do
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:destination, :forecast, :salaries]
      salary_keys = [:title, :min, :max]
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get "/api/v1/salaries?destination=denver", headers: headers, params: JSON.generate(body)
      
      salaries = JSON.parse(response.body, symbolize_names: true)   
     
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(salaries).to have_key(:data)
      expect(salaries[:data].keys).to eq(data_keys)
      expect(salaries[:data][:attributes].keys).to eq(attribute_keys)
      expect(salaries[:data][:attributes][:salaries]).to be_a(Array)
      expect(salaries[:data][:attributes][:salaries].count).to eq(7)
      salaries[:data][:attributes][:salaries].each do |salary|
        expect(salary.keys).to eq(salary_keys)
      end
    end
  end
end
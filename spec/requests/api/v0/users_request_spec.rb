require 'rails_helper'

RSpec.describe 'Users request spec', type: :request do
  describe '#create' do
    it 'adds a user to the database, generates an api key and returns a successful response with id, email and api key' do
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:email, :api_key]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {

        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'password'

      }
      post "/api/v0/users", headers:, params: JSON.generate(body)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(user).to have_key(:data)
      expect(user[:data].keys).to eq(data_keys)
      expect(user[:data][:attributes].keys).to eq(attribute_keys)
    end

    it "returns an error response if the passwords dont match" do
      error_keys = [:status, :title, :detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {

        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'passwor'

      }
      post "/api/v0/users", headers:, params: JSON.generate(body)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:detail]).to eq(["Passwords do not match"])
    end

    it "returns an error response if the email is already in the dtabase" do
      error_keys = [:status, :title, :detail]
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {

        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'password'

      }
      post "/api/v0/users", headers:, params: JSON.generate(body)
      post "/api/v0/users", headers:, params: JSON.generate(body)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(error).to have_key(:errors)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:detail]).to eq(["Validation failed: Email has already been taken"])
    end
  end
end

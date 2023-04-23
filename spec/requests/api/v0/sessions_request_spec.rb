require 'rails_helper'

RSpec.describe 'Sessions request spect', type: :request do
  describe '#create' do
    it 'it authenticates a user and returns a user object if successful' do
      data_keys = [ :id, :type, :attributes]
      attribute_keys = [:email, :api_key]
      user = User.create!(email: "whatever@example.com", password: 'password')
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {
        
        'email': 'whatever@example.com',
        'password': 'password'                                         
              }
      post "/api/v0/sessions", headers: headers, params: JSON.generate(body)
      
      user = JSON.parse(response.body, symbolize_names: true)   

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user).to have_key(:data)
      expect(user[:data].keys).to eq(data_keys)
      expect(user[:data][:attributes].keys).to eq(attribute_keys)
      expect(user[:data][:attributes][:email]).to eq("whatever@example.com")
    end

    it 'it returns an error object if the email is invalid' do
      error_keys = [:status, :title, :detail]
      user = User.create!(email: "whatever@example.com", password: 'password')
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {
        
        'email': 'whateve@example.com',
        'password': 'password'                                         
              }
      post "/api/v0/sessions", headers: headers, params: JSON.generate(body)
      
      error = JSON.parse(response.body, symbolize_names: true)   

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:detail]).to eq(["Invalid input"])
    end

    it 'it returns an error object if the password is invalid' do
      error_keys = [:status, :title, :detail]
      user = User.create!(email: "whatever@example.com", password: 'password')
      headers = { 'CONTENT_TYPE' => 'application/json' }

      body =  {
        
        'email': 'whatever@example.com',
        'password': 'passw'                                         
              }
      post "/api/v0/sessions", headers: headers, params: JSON.generate(body)
      
      error = JSON.parse(response.body, symbolize_names: true)   
    
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(error).to have_key(:errors)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:detail]).to eq(["Invalid email/password"])
    end
  end
end
require 'rails_helper'

RSpec.describe 'Forecast request spec', type: :request do
  describe '#show', :vcr do
    it 'returns a single forecast with the specified attributes' do

      get "/api/v0/forecast?location=Denver, CO"

      forecast = JSON.parse(response.body, symbolize_names: true)
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:current_weather, :daily_weather, :hourly_weather]
      current_keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]
      daily_keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon]
      hourly_keys = [:time, :temperature, :conditions, :icon]
  
      expect(response).to be_successful
      expect(forecast).to be_a(Hash)
      expect(forecast).to have_key(:data)
      expect(forecast[:data].keys).to eq(data_keys)

      expect(forecast[:data][:attributes].keys).to eq(attribute_keys)
      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data][:type]).to eq("forecast")

      expect(forecast[:data][:attributes][:current_weather].keys).to eq(current_keys)
      expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:condition]).to be_a(String)
      expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)
     
      expect(forecast[:data][:attributes][:daily_weather]).to be_a(Array)
      expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
      forecast[:data][:attributes][:daily_weather].each do |day|
        expect(day.keys).to eq(daily_keys)
        expect(day[:date]).to be_a(String)
        expect(day[:sunrise]).to be_a(String)
        expect(day[:sunset]).to be_a(String)
        expect(day[:max_temp]).to be_a(Float)
        expect(day[:min_temp]).to be_a(Float)
        expect(day[:condition]).to be_a(String)
        expect(day[:icon]).to be_a(String)
      end

      expect(forecast[:data][:attributes][:hourly_weather]).to be_a(Array)
      expect(forecast[:data][:attributes][:hourly_weather].count).to eq(24)
      forecast[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour.keys).to eq(hourly_keys)
        expect(hour[:time]).to be_a(String)
        expect(hour[:temperature]).to be_a(Float)
        expect(hour[:conditions]).to be_a(String)
        expect(hour[:time]).to be_a(String)
      end
    end

    it 'retuns an error if the location input is invalid' do
      get "/api/v0/forecast?location="
      error = JSON.parse(response.body, symbolize_names: true)
      error_keys = [:status, :title, :detail]

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(error).to have_key(:errors)
      expect(error[:errors].first.keys).to eq(error_keys)
      expect(error[:errors].first[:status]).to eq("400")
      expect(error[:errors].first[:title]).to eq("Invalid Request")
      expect(error[:errors].first[:detail]).to eq(["Invalid input"])
    end
  end
end

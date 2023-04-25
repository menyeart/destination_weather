require 'rails_helper'

RSpec.describe 'API Key' do
  describe 'creation' do
    it 'will create an api key' do
      key = ApiKey.generator

      expect(key).to be_kind_of(String)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Get welcome message' do
  context '#successful' do
    it 'returns welcome message' do
      send(:get, '/')
      result = JSON.parse(response.body)

      expect(result['message']).to eq('Welcome to Liga Mx stats')
      expect(response.status).to eq(200)
    end
  end
end

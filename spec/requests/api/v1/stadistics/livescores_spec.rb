require 'rails_helper'

RSpec.describe 'Show Livescores', vcr: { record: :none } do
  context '#successful' do
    it 'list all livescores from the league' do
      send(:get, '/stadistics/livescores')
      result = JSON.parse(response.body)

      expect(result).to be_a(Array)
      expect(response.status).to eq(200)
    end
  end
end

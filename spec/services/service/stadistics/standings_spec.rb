require 'rails_helper'

RSpec.describe Service::Stadistics::Standings, vcr: { record: :none } do
  describe 'Get Standings' do
    let(:service) { described_class }

    context '#successful' do
      let (:success_ws_response) do
        {
          "data" => {
            "table" => [
              {
                "league_id": "0",
                "season_id": "13",
                "name": "CF America",
                "rank": "1",
                "points": "35",
                "matches": "17",
                "goal_diff": "11",
                "goals_scored": "21",
                "goals_conceded": "10",
                "lost": "2",
                "drawn": "5",
                "won": "10",
                "team_id": "1067",
                "competition_id": "45",
                "group_id": "1358",
                "group_name": "1",
                "stage_name": "Apertura",
                "stage_id": "1763"
              }
            ]
          }
        }
      end

      it 'returns authorization' do
        stub_ws_response(success_ws_response)
        result = execute_service

        expect(result).to be_a(Array)
      end
    end

    context '#failed' do
      context 'failed when request' do
        it 'returns nil' do
          stub_ws_response(nil)
          expect do
            execute_service
          end.to raise_error(RuntimeError, 'Unexpected Error')
        end
      end
      context 'timeout when request' do
        it 'raise timeout' do
          allow(WebService::Client.instance).to receive(:make_request).and_raise(Faraday::TimeoutError)

          expect do
            execute_service
          end.to raise_error(Faraday::TimeoutError, 'timeout')
        end
      end

      context 'Figaro env variable are nil' do
        it 'raise timeout' do
          allow(Figaro.env).to receive(:standings_endpoint).and_return(nil)

          expect do
            execute_service
          end.to raise_error(RuntimeError, 'Parser error')
        end
      end
    end
  end

  def execute_service
    service.new.execute
  end

  def stub_ws_response(response)
    allow(WebService::Client.instance).to receive(:make_request).and_return(response)
  end
end

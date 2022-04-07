require 'rails_helper'

RSpec.describe Service::Stadistics::Livescores, vcr: { record: :none } do
  describe 'Get Livescores' do
    let(:service) { described_class }

    context '#successful' do
      let (:success_ws_response) do
        {
          "data" => {
            "match" => [
              {
                "competition_name" => "Liga MX",
                "league_id" => 0,
                "has_lineups" => false,
                "odds" => {
                  "pre" => {
                    "1" => 4,
                    "2" => 1.91,
                    "X" => 3.5
                  }
                },
                "id" => 317856,
                "home_id" => 1050,
                "away_name" => "Monterrey",
                "league_name" => "",
                "country" => {
                  "id" => 57,
                  "name" => "Mexico"
                },
                "events" => "https://livescore-api.com/api-client/scores/events.json?key=sASuCpO9skbz3Qhw&amp;secret=unL319DF2ywt4sTw3L0FbOPD91ccRuJm&amp;id=317856",
                "federation" => nil,
                "ht_score" => "1 - 2",
                "score" => "2 - 2",
                "ps_score" => "",
                "scheduled" => "00:00",
                "et_score" => "",
                "last_changed" => "2022-04-07 02:04:36",
                "fixture_id" => 1516916,
                "home_name" => "Toluca",
                "competition_id" => 45,
                "added" => "2022-04-06 23:45:35",
                "location" => "Estadio Nemesio Díez",
                "h2h" => "https://livescore-api.com/api-client/teams/head2head.json?team1_id=1050&secret=unL319DF2ywt4sTw3L0FbOPD91ccRuJm&key=sASuCpO9skbz3Qhw&team2_id=768",
                "away_id" => 768,
                "status" => "FINISHED",
                "ft_score" => "2 - 2",
                "time" => "FT",
                "outcomes" => {
                  "half_time" =>"2",
                  "full_time" => "X",
                  "extra_time" => nil
                },
                "info" => "This match is only supported through the new competitions structure"
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
          allow(Figaro.env).to receive(:livescores_endpoint).and_return(nil)

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

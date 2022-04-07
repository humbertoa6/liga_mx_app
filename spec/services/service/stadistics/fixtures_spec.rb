require 'rails_helper'

RSpec.describe Service::Stadistics::Fixtures, vcr: { record: :none } do
  describe 'Get Fixtures' do
    let(:service) { described_class }

    context '#successful' do
      let (:success_ws_response) do
        {
          "data" => {
            "fixtures" => [
              {
                "league_id": 341,
                "away_name": "Tigres",
                "odds": {
                  "live": {
                    "1": 'null',
                    "2": 'null',
                    "X": 'null'
                  },
                  "pre": {
                    "1": 2.5,
                    "2": 2.8,
                    "X": 3.25
                  }
                },
                "home_translations": {
                  "fa": "پاچوکا",
                  "ru": "Пачука",
                  "ar": "باتشوكا"
                },
                "date": "2022-04-08",
                "id": 1516907,
                "home_id": 459,
                "competition_id": 45,
                "away_translations": {
                  "fa": "تیگرس",
                  "ru": "Тигрес УАНЛ",
                  "ar": "تيغريس"
                },
                "location": "Estadio Hidalgo",
                "h2h": "https://livescore-api.com/api-client/teams/head2head.json?team1_id=459&secret=unL319DF2ywt4sTw3L0FbOPD91ccRuJm&key=sASuCpO9skbz3Qhw&team2_id=767",
                "competition": {
                  "id": 45,
                  "name": "Liga MX"
                },
                "away_id": 767,
                "league": {
                  "id": 341,
                  "country_id": 57,
                  "name": "Liga MX:: clausura"
                },
                "home_name": "Pachuca",
                "round": "9",
                "time": "00:00:00"
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
          allow(Figaro.env).to receive(:fixtures_endpoint).and_return(nil)

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

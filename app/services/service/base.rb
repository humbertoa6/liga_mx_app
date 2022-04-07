require 'web_service/client'

module Service
  class Base
    def initialize; end

    def execute
      response
    end

    private

    def make_request
      WebService::Client.instance.make_request(endpoint: endpoint, params: params, method_name: :get)
    end

    def params
      {
        competition_id: Figaro.env.competition_id,
        key: Figaro.env.key,
        secret: Figaro.env.secret
      }
    end
  end
end

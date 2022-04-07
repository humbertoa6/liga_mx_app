module Service
  module Stadistics
    class Standings < Service::Base
      private

      def response
        make_request.dig('data', 'table')
      rescue NoMethodError => _e
        raise 'Unexpected Error'
      end

      def endpoint
        Figaro.env.standings_endpoint
      end
    end
  end
end

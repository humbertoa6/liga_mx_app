module Service
  module Stadistics
    class Livescores < Service::Base
      private

      def response
        make_request.dig('data', 'match')
      rescue NoMethodError => _e
        raise 'Unexpected Error'
      end

      def endpoint
        Figaro.env.livescores_endpoint
      end
    end
  end
end

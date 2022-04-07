module Service
  module Stadistics
    class Fixtures < Service::Base
      private

      def response
        make_request.dig('data', 'fixtures')
      rescue NoMethodError => _e
        raise 'Unexpected Error'
      end

      def endpoint
        Figaro.env.fixtures_endpoint
      end
    end
  end
end

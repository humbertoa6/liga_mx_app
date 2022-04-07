module WebService
  class Client
    include Singleton

    def make_request(endpoint:, method_name:, params: nil)
      response = connection.send(method_name) do |request|
        request.url "#{endpoint}.json"
        request.params = params
        request.headers = @headers || {}
        request.headers['Content-Type'] = 'application/json'
      end

      parse_response(response)
    end

    private

    def connection
      Faraday.new(url: base_url)
    end

    def parse_response(response)
      JSON.parse(response.body)
    rescue JSON::ParserError
      PayerError.unavailable.to_h
    rescue Faraday::TimeoutError
      PayerError.timeout.to_h
    rescue Faraday::ConnectionFailed, Errno::ECONNREFUSED
      PayerError.server_error.to_h
    end

    def base_url
      Figaro.env.base_url
    end
  end
end

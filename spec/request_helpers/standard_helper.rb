module StandardHelper
  def request(http_method, endpoint, parameters)
    send(http_method, endpoint, params: parameters, headers: { 'Content-Type': 'application/json' })
  end

  def json_body
    @json_body ||= JSON.parse(response.body)
  end
end

ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
  VCR.configure do |config|
    config.allow_http_connections_when_no_cassette = false
    config.cassette_library_dir = File.expand_path('cassettes', __dir__)
    config.hook_into :webmock
    config.ignore_request { ENV['DISABLE_VCR'] }
    config.ignore_localhost = true
    config.default_cassette_options = {
      record: :new_episodes
    }
  end
  # Add more helper methods to be used by all tests here...
end

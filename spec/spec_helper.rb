require "airwallex"
require "webmock/rspec"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def stub_api_request(method, path, response_body, status: 200)
  stub_request(method, /api(-demo)?\.airwallex\.com#{path}/)
    .to_return(
      status: status,
      body: response_body.to_json,
      headers: { "Content-Type" => "application/json" },
    )
end

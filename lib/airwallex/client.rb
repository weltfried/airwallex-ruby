module Airwallex
  class Client
    BASE_URLS = {
      production: "https://api.airwallex.com",
      sandbox: "https://api-demo.airwallex.com",
    }.freeze

    attr_reader :api_key, :client_id, :environment

    def initialize(api_key:, client_id:, environment: :production)
      @api_key = api_key
      @client_id = client_id
      @environment = environment
      @access_token = nil
      @token_expires_at = nil
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, body = {}, idempotency_key: nil)
      request(:post, path, body, idempotency_key: idempotency_key)
    end

    private

    def request(method, path, data = {}, idempotency_key: nil)
      refresh_token if token_expired?

      response = connection.send(method) do |req|
        req.url path
        req.headers["Authorization"] = "Bearer #{@access_token}"
        req.headers["Content-Type"] = "application/json"
        req.headers["Idempotency-Key"] = idempotency_key if idempotency_key

        if method == :get
          req.params = data
        else
          req.body = data.to_json
        end
      end

      handle_response(response)
    rescue Faraday::Error => e
      raise Airwallex::Error, e
    end

    def connection
      @connection ||= Faraday.new(url: BASE_URLS[environment]) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def refresh_token
      response = connection.post("/api/v1/authentication/login") do |req|
        req.headers["x-api-key"] = api_key
        req.headers["x-client-id"] = client_id
      end

      data = handle_response(response)
      @access_token = data["token"]
      @token_expires_at = Time.now + data["expires_in"]
    end

    def token_expired?
      @access_token.nil? || @token_expires_at.nil? || Time.now >= @token_expires_at
    end

    def handle_response(response)
      case response.status
      when 200..299
        response.body
      else
        raise Airwallex::Error, "#{response.status}: #{response.body}"
      end
    end
  end
end

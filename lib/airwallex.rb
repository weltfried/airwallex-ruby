require "faraday"
require "json"
require_relative "airwallex/version"
require_relative "airwallex/client"
require_relative "airwallex/errors"
require_relative "airwallex/resources/payment"
require_relative "airwallex/resources/customer"
require_relative "airwallex/resources/payout"

module Airwallex
  class << self
    attr_accessor :api_key, :client_id, :environment, :webhook_secret

    def configure
      yield self
    end

    def client
      @client ||= Client.new(
        api_key: api_key,
        client_id: client_id,
        environment: environment || :production,
      )
    end

    def verify_webhook(payload, signature)
      Webhook.verify(payload, signature)
    end

    def construct_webhook_event(payload, signature)
      Webhook.construct_event(payload, signature)
    end
  end
end

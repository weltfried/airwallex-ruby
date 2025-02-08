module Airwallex
  class Webhook
    SIGNATURE_HEADER = "x-signature"

    class << self
      attr_accessor :webhook_secret

      def verify(payload, signature)
        return false unless webhook_secret && signature

        expected = OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest.new("sha256"),
          webhook_secret,
          payload
        )

        Rack::Utils.secure_compare(expected, signature)
      end

      def construct_event(payload, signature)
        raise WebhookError, "No signature provided" unless signature

        unless verify(payload, signature)
          raise WebhookError, "Invalid signature"
        end

        JSON.parse(payload)
      rescue JSON::ParserError
        raise WebhookError, "Invalid payload"
      end
    end
  end
end

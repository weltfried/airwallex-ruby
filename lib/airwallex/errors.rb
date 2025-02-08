module Airwallex
  class Error < StandardError; end
  class AuthenticationError < Error; end
  class InvalidRequestError < Error; end
  class APIError < Error; end
  class RateLimitError < Error; end
  class IdempotencyError < Error; end
  class WebhookError < Error; end

  class ValidationError < Error
    attr_reader :param

    def initialize(message, param)
      super(message)
      @param = param
    end
  end
end

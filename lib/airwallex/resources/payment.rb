module Airwallex
  class Payment
    def initialize(client)
      @client = client
    end

    def create(params)
      @client.post("/api/v1/payments/create", params)
    end

    def retrieve(id)
      @client.get("/api/v1/payments/#{id}")
    end

    def list(params = {})
      @client.get("/api/v1/payments", params)
    end
  end
end

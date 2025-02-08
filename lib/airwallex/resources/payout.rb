module Airwallex
  class Payout
    def initialize(client)
      @client = client
    end

    def create(params)
      @client.post("/api/v1/payouts/create", params)
    end

    def retrieve(id)
      @client.get("/api/v1/payouts/#{id}")
    end

    def list(params = {})
      @client.get("/api/v1/payouts", params)
    end

    def confirm(id)
      @client.post("/api/v1/payouts/#{id}/confirm")
    end
  end
end

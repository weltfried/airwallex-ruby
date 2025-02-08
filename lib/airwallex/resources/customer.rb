module Airwallex
  class Customer
    def initialize(client)
      @client = client
    end

    def create(params)
      @client.post("/api/v1/customers", params)
    end

    def retrieve(id)
      @client.get("/api/v1/customers/#{id}")
    end

    def update(id, params)
      @client.post("/api/v1/customers/#{id}", params)
    end

    def list(params = {})
      @client.get("/api/v1/customers", params)
    end

    def delete(id)
      @client.post("/api/v1/customers/#{id}/delete")
    end
  end
end

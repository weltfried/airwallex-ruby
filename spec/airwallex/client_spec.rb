require "spec_helper"

RSpec.describe Airwallex::Client do
  let(:client) do
    described_class.new(
      api_key: "test_key",
      client_id: "test_client",
      environment: :sandbox,
    )
  end

  describe "#request" do
    before do
      stub_api_request(:post, "/api/v1/authentication/login",
                       { "token" => "test_token", "expires_in" => 3600 })
    end

    it "handles successful requests" do
      stub_api_request(:get, "/api/v1/payments/test123",
                       { "id" => "test123", "status" => "succeeded" })

      response = client.get("/api/v1/payments/test123")
      expect(response["id"]).to eq("test123")
    end

    it "handles errors" do
      stub_api_request(:get, "/api/v1/payments/invalid",
                       { "code" => "invalid_request", "message" => "Payment not found" },
                       status: 404)

      expect {
        client.get("/api/v1/payments/invalid")
      }.to raise_error(Airwallex::Error, /404:.*Payment not found/)
    end
  end
end

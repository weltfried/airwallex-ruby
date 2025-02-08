## Usage

### Configuration

```ruby
Airwallex.configure do |config|
  config.api_key = "your_api_key"
  config.client_id = "your_client_id"
  config.environment = :sandbox # or :production
  config.webhook_secret = "your_webhook_secret" # Optional, for webhook verification
end
```

### Idempotency

```ruby
# Use idempotency keys to prevent duplicate requests
payment = Airwallex.client.payment.create({
  amount: 10.00,
  currency: "USD",
  # ... other parameters ...
}, idempotency_key: "unique_request_id")
```

### Webhook Handling

```ruby
# In your webhook endpoint
post "/webhook" do
  payload = request.body.read
  signature = request.env["HTTP_X_SIGNATURE"]

  begin
    event = Airwallex.construct_webhook_event(payload, signature)
    case event["type"]
    when "payment.succeeded"
      # Handle successful payment
    when "payment.failed"
      # Handle failed payment
    end
  rescue Airwallex::WebhookError => e
    # Handle invalid webhook
  end
end
```

### Error Handling

```ruby
begin
  payment = Airwallex.client.payment.create(params)
rescue Airwallex::AuthenticationError => e
  # Handle authentication error
rescue Airwallex::InvalidRequestError => e
  # Handle invalid request
rescue Airwallex::APIError => e
  # Handle API error
rescue Airwallex::RateLimitError => e
  # Handle rate limit error
end
```

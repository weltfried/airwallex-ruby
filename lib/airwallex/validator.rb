module Airwallex
  module Validator
    class ValidationError < Airwallex::Error; end

    def self.validate_required!(params, *keys)
      keys.each do |key|
        raise ValidationError, "Missing required parameter: #{key}" unless params.key?(key)
      end
    end

    def self.validate_number!(params, *keys)
      keys.each do |key|
        next unless params.key?(key)
        unless params[key].is_a?(Numeric)
          raise ValidationError, "#{key} must be a number"
        end
      end
    end

    def self.validate_string!(params, *keys)
      keys.each do |key|
        next unless params.key?(key)
        unless params[key].is_a?(String)
          raise ValidationError, "#{key} must be a string"
        end
      end
    end
  end
end

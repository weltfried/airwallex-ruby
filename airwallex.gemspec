Gem::Specification.new do |s|
  s.name = "airwallex"
  s.version = "0.1.0"
  s.summary = "Ruby wrapper for the Airwallex API"
  s.description = "A Ruby library for interacting with the Airwallex payment API"
  s.authors = ["Your Name"]
  s.email = "your.email@example.com"
  s.files = Dir["lib/**/*", "LICENSE", "README.md"]
  s.homepage = "https://github.com/yourusername/airwallex"
  s.license = "MIT"

  s.required_ruby_version = ">= 2.7.0"

  s.add_dependency "faraday", "~> 2.0"
  s.add_dependency "faraday-multipart", "~> 1.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "webmock", "~> 3.0"
end

RSpec.configure do |config|
  config.before :each do
    ENV["SECRET_KEY_BASE"] ||= "test-secret-key-base"
    ENV["GOOGLE_MAPS_API_KEY"] ||= "google-maps-api-key"
    ENV["GOOGLE_MAPS_EMBED_KEY"] ||= "google-maps-embed-key"
  end
end

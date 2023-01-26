RSpec.configure do |config|
  config.before :each do
    ENV["SECRET_KEY_BASE"] ||= "test-secret-key-base"
  end
end

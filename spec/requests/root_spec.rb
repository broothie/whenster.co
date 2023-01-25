require 'rails_helper'

RSpec.describe "Root", type: :request do
  describe "#healthz" do
    it "works" do
      get "/healthz.json"
      expect(response).to be_ok

      payload = JSON.parse(response.body)
      expect(payload).to include "rails_env"
      expect(payload).to include "service_env"
      expect(payload).to include "env"
    end
  end
end

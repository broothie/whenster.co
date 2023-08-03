require 'rails_helper'

RSpec.describe Api::ProxyController, type: :request do
  describe "#google_maps_places_search" do
    let(:user) { create(:user) }

    it "hits the google maps api" do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/findplacefromtext/json")
        .with(query: hash_including(input: "bobs on baker"))
        .to_return(body: { candidates: [{ name: "Bob's Donuts" }] }.to_json)

      get "/api/proxy/google_maps_places_search",
        headers: { Authorization: "Token #{user.generate_jwt}" },
        params: { input: "bobs on baker" }

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to eq "candidates" => [{ "name" => "Bob's Donuts" }]
    end
  end
end

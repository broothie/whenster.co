require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let(:event) { create(:event) }
  let(:invite) { event.invites.first }
  let(:user) { invite.user }
  let(:post_attrs) { attributes_for(:post) }

  describe "#index" do
    let!(:posts) { create_list(:post, 3, invite:) }

    it "returns a list of event posts" do
      get "/api/events/#{event.id}/posts", headers: { Authorization: "Token #{user.generate_jwt}" }
      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("posts", 0, "body")).to eq posts.first.body
    end
  end

  describe "#create" do
    it "creates a post" do
      expect {
        post "/api/events/#{event.id}/posts",
          headers: { Authorization: "Token #{user.generate_jwt}" },
          params: { post: { body: post_attrs[:body] } }
      }.to change { user.posts.count }

      expect(response.status).to eq 201
      payload = JSON.parse(response.body)
      expect(payload.dig("post", "body")).to eq post_attrs[:body]
    end
  end

  describe "#show" do
    let(:poast) { create(:post, invite:) }

    it "returns a post" do
      get "/api/events/#{event.id}/posts/#{poast.id}", headers: { Authorization: "Token #{user.generate_jwt}" }
      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("post", "body")).to eq poast.body
    end
  end

  describe "#show" do
    let(:poast) { create(:post, invite:) }

    it "updates a post" do
      expect {
        patch "/api/events/#{event.id}/posts/#{poast.id}",
          headers: { Authorization: "Token #{user.generate_jwt}" },
          params: { post: { body: post_attrs[:body] } }
      }.to change { poast.reload.body }

      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("post", "body")).to eq post_attrs[:body]
    end
  end
end

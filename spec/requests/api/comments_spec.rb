require 'rails_helper'

RSpec.describe "Api::Comments", type: :request do
  let(:poast) { create(:post) }
  let(:event) { poast.event }
  let(:invite) { create(:invite, event:) }
  let(:user) { invite.user }
  let(:comment_attrs) { attributes_for(:comment) }

  describe "#create" do
    it "creates a comment" do
      expect {
        post "/api/events/#{event.id}/posts/#{poast.id}/comments",
          headers: auth_headers(user),
          params: { comment: { body: comment_attrs[:body] } }
      }.to change { poast.comments.count }.by(1)

      expect(response.status).to eq 201
      payload = JSON.parse(response.body)
      expect(payload.dig("comment", "body")).to eq comment_attrs[:body]
    end
  end

  describe "#update" do
    let(:comment) { create(:comment, invite:, post: poast) }

    it "updates the comment" do
      expect {
        patch "/api/events/#{event.id}/posts/#{poast.id}/comments/#{comment.id}",
          headers: auth_headers(user),
          params: { comment: { body: comment_attrs[:body] } }
      }.to change { comment.reload.body }.from(comment.body).to(comment_attrs[:body])

      expect(response.status).to eq 200
      payload = JSON.parse(response.body)
      expect(payload.dig("comment", "body")).to eq comment_attrs[:body]
    end
  end

  describe "#destroy" do
    let!(:comment) { create(:comment, invite:, post: poast) }

    it "destroys the comment" do
      expect {
        delete "/api/events/#{event.id}/posts/#{poast.id}/comments/#{comment.id}",
          headers: auth_headers(user)
      }.to change { poast.comments.count }.by(-1)

      expect(response.status).to eq 200
    end
  end
end

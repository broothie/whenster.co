require 'rails_helper'

RSpec.describe InviteSearch do
  describe "#search" do
    subject(:invite_search) { InviteSearch.new(event, username_query) }

    let!(:invited_user) { create(:user, username: "user_invited") }
    let!(:uninvited_user) { create(:user, username: "user_uninvited") }
    let(:event) { create(:event, invites: [{ user: invited_user }]) }
    let(:search) { invite_search.search }

    context "when not invited" do
      context "when exact username" do
        let(:username_query) { "user_uninvited" }

        it "finds the uninvited user" do
          expect(search).to include uninvited_user
        end
      end

      context "when fuzzy username" do
        let(:username_query) { "user" }

        it "finds the uninvited user" do
          expect(search).to include uninvited_user
        end
      end
    end

    context "when invited" do
      context "when exact username" do
        let(:username_query) { "user_invited" }

        it "does not find the uninvited user" do
          expect(search).not_to include invited_user
        end
      end
    end
  end
end

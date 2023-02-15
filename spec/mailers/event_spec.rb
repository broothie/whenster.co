require "rails_helper"

RSpec.describe EventMailer, type: :mailer do
  describe "#soon" do
    let(:event) { create(:event) }
    let(:invite) { create(:invite, event:) }
    let(:user) { invite.user }
    let(:email) { EventMailer.with(event_id: event.id, user_id: user.id).soon }

    it "works" do
      expect(email.to).to include user.email
      expect(email.subject).to eq "#{event.title} starts soon!"

      expect(email.html_part.body).to include "Hey #{user.username} 👋"
      expect(email.html_part.body).to include event.title
      expect(email.html_part.body).to include Config.base_url("events", event.id)

      expect(email.text_part.body).to include "Hey #{user.username} 👋"
      expect(email.text_part.body).to include event.title
      expect(email.html_part.body).to include Config.base_url("events", event.id)
    end
  end

  describe "#tomorrow" do
    let(:event) { create(:event) }
    let(:invite) { create(:invite, event:) }
    let(:user) { invite.user }
    let(:email) { EventMailer.with(event_id: event.id, user_id: user.id).tomorrow }

    it "works" do
      expect(email.to).to include user.email
      expect(email.subject).to eq "#{event.title} is tomorrow!"

      expect(email.html_part.body).to include "Hey #{user.username} 👋"
      expect(email.html_part.body).to include event.title
      expect(email.html_part.body).to include Config.base_url("events", event.id)

      expect(email.text_part.body).to include "Hey #{user.username} 👋"
      expect(email.text_part.body).to include event.title
      expect(email.html_part.body).to include Config.base_url("events", event.id)
    end
  end

  describe "#next_week" do
    let(:event) { create(:event) }
    let(:invite) { create(:invite, event:) }
    let(:user) { invite.user }
    let(:email) { EventMailer.with(event_id: event.id, user_id: user.id).next_week }

    it "works" do
      expect(email.to).to include user.email
      expect(email.subject).to eq "#{event.title} is coming up!"

      expect(email.html_part.body).to include "Hey #{user.username} 👋"
      expect(email.html_part.body).to include event.title
      expect(email.html_part.body).to include Config.base_url("events", event.id)

      expect(email.text_part.body).to include "Hey #{user.username} 👋"
      expect(email.text_part.body).to include event.title
      expect(email.html_part.body).to include Config.base_url("events", event.id)
    end
  end
end

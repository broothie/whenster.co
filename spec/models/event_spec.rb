# == Schema Information
#
# Table name: events
#
#  id          :uuid             not null, primary key
#  description :text
#  end_at      :datetime         not null
#  location    :string
#  start_at    :datetime         not null
#  timezone    :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  place_id    :string
#
# Indexes
#
#  index_events_on_end_at    (end_at)
#  index_events_on_start_at  (start_at)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { create(:event) }

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :start_at }
    it { should validate_presence_of :end_at }
  end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { create(:post) }

  describe "validations" do
    it { should validate_presence_of :invite }
  end
end

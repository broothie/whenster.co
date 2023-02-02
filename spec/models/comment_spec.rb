require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { create(:comment) }

  describe "validations" do
    it { should validate_presence_of :invite }
    it { should validate_presence_of :post }
  end
end

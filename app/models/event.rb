class Event < ApplicationRecord
  has_many :invites, dependent: :destroy
  has_many :users, through: :invites

  validates :title, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_in_future!, on: :create
  validate :start_at_before_end_at!
  validate :editable!

  def future?
    start_at.future?
  end

  def happening_now?
    start_at.past? && end_at.future?
  end

  def past?
    end_at.past?
  end

  private

  def start_at_in_future!
    return unless start_at

    errors.add(:start_at, "must be in future") unless future?
  end

  def start_at_before_end_at!
    return unless start_at
    return unless end_at

    errors.add(:end_at, "must be after start_at") unless end_at.after?(start_at)
  end

  def editable!
    return unless end_at

    errors.add(:event, "is no longer editable") if past?
  end
end
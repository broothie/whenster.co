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
class Event < ApplicationRecord
  include EventViewHelpers

  has_many :invites, dependent: :destroy
  has_many :users, through: :invites
  has_many :posts, through: :invites
  has_many :comments, through: :posts

  has_one_attached :header_image do |image|
    image.variant :size_300, resize_to_limit: [300, 300], auto_orient: false
    image.variant :size_1500, resize_to_limit: [1500, 1500], auto_orient: false
  end

  accepts_nested_attributes_for :invites

  validates :title, presence: true
  validates :description, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_in_future!, on: :create
  validate :start_at_before_end_at!
  validate :editable!

  after_save :set_timezone_from_place_id!, if: -> { place_id? && saved_change_to_place_id? }

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

  def set_timezone_from_place_id!
    SetEventTimezoneFromPlaceIdJob.perform_async(id)
  end
end

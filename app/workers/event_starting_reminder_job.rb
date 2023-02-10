# typed: true
class EventStartingReminderJob
  extend T::Sig
  include Cloudtasker::Worker

  sig {void}
  def perform
    now = Time.now
    window_start = now.beginning_of_hour
    window_end = window_start + 1.hour

    Event.where(start_at: window_start..window_end).pluck(:id).each do |event_id|
      EventMailer.starting!(event_id)
    end
  end
end

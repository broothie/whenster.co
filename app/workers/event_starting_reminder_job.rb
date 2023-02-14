# typed: true
class EventStartingReminderJob
  extend T::Sig
  include Cloudtasker::Worker

  sig {params(event_id: T.nilable(String)).void}
  def perform(event_id = nil)
    if event_id
      perform_per_event(event_id)
    else
      perform_dispatch
    end
  end

  private

  sig {void}
  def perform_dispatch
    now = Time.now
    window_start = now.beginning_of_hour
    window_end = window_start + 1.hour

    Event.where(start_at: window_start..window_end).pluck(:id).each do |event_id|
      EventStartingReminderJob.perform_async(event_id)
    end
  end

  sig {params(event_id: String).void}
  def perform_per_event(event_id)
    event = Event.eager_load(:invites).find(event_id)
    user_ids = event.invites.going.map(&:user_id)

    user_ids.each do |user_id|
      EventMailer.with(event_id: event.id, user_id:).starting.deliver_later
    end
  end
end

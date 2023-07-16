# typed: true
class EventReminderJob
  extend T::Sig
  include Sidekiq::Job

  class InvalidDistanceError < StandardError; end

  DISTANCES = %w[soon tomorrow next_week].freeze

  sig {params(distance: T.nilable(String), event_id: T.nilable(String)).void}
  def perform(distance = nil, event_id = nil)
    return perform_dispatch_distances unless distance
    raise InvalidDistanceError, "invalid distance '#{distance}'" unless DISTANCES.include?(distance)
    return perform_find_events(distance) unless event_id

    perform_send_emails(distance, event_id)
  end

  private

  sig {void}
  def perform_dispatch_distances
    DISTANCES.each do |distance|
      EventReminderJob.perform_async(distance)
    end
  end

  sig {params(distance: String).void}
  def perform_find_events(distance)
    Event.where(start_at: window(distance)).pluck(:id).each do |event_id|
      EventReminderJob.perform_async(distance, event_id)
    end
  end

  sig {params(distance: String, event_id: String).void}
  def perform_send_emails(distance, event_id)
    event = Event.eager_load(:invites).find(event_id)
    user_ids = event.invites.going.map(&:user_id)

    user_ids.each do |user_id|
      EventMailer.with(event_id: event.id, user_id:).send(distance).deliver_later
    end
  end

  sig {params(distance: String).returns(ActiveSupport::Duration)}
  def offset(distance)
    case distance
    when "soon" then 0.seconds
    when "tomorrow" then 1.day
    when "next_week" then 1.week
    else raise InvalidDistanceError, "invalid distance '#{distance}'"
    end
  end

  sig {params(distance: String).returns(Range)}
  def window(distance)
    now = Time.now
    window_start = now.beginning_of_hour + offset(distance)
    window_end = window_start + 1.hour

    window_start..window_end
  end
end

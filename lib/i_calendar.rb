class ICalendar
  TIMESTAMP_FORMAT = "%Y%m%dT%H%M%S".freeze

  STATUSES = {
    "attending" => "CONFIRMED",
    "tentative" => "TENTATIVE",
    "bailing" => "CANCELLED",
  }.freeze

  def initialize(user)
    @user = user
  end

  def to_s
    calendar.to_ical
  end

  def calendar
    @calendar ||= build_calendar
  end

  def build_calendar
    calendar = Icalendar::Calendar.new
    calendar.x_wr_calname = "Whenster"

    @user.invites.not_pending.includes(:event).each do |invite|
      calendar.event do |event|
        event.uid = invite.event.id
        event.dtstart = invite.event.start_at.utc
        event.dtend = invite.event.end_at.utc
        event.summary = invite.event.title
        event.description = invite.event.description
        event.status = STATUSES[invite.status]
        event.url = AppConfig.base_url("events", invite.event.id)

        if invite.event.header_image.attached?
          event.image = UrlHelpers.url_for(invite.event.header_image.variant(:size_1500))
        end
      end
    end

    calendar
  end
end

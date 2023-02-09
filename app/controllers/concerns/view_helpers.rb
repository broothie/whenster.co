# typed: false
module ViewHelpers
  extend T::Sig

  EVENT_HEADER_IMAGE_URLS = [
    # Yellow abstract
    "https://img.freepik.com/free-vector/hand-drawn-abstract-doodle-pattern-design_23-2149268666.jpg",
    # Confetti
    "https://images.unsplash.com/photo-1513151233558-d860c5398176?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
    # White bokeh lights
    "https://images.unsplash.com/photo-1519751138087-5bf79df62d5b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
    # Pink + white
    "https://images.unsplash.com/photo-1546050680-d4305dcff705?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3432&q=80",
  ]

  delegate :base_url, to: Config

  def self.markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true), autolink: true)
  end

  sig {returns(T.nilable(String))}
  def public_css_filename
    filepath = Dir.glob("public/index.*.css").first
    return nil unless filepath

    File.basename(filepath)
  end

  sig {params(markdown: String).returns(String)}
  def markdown(markdown)
    ViewHelpers.markdown_renderer.render(markdown).html_safe
  end

  def long_time_format
    "%A, %B %e, %l%P %Z"
  end

  sig {params(user: User).returns(String)}
  def user_calendar_url(user)
    base_url("calendar", "#{user.calendar_token}.ics")
  end

  sig {params(user: User).returns(String)}
  def gravatar_url(user)
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?d=retro"
  end

  sig {params(file: T.untyped, fallback: String).returns(String)}
  def file_url(file, fallback)
    file.present? ? url_for(file) : fallback
  end

  sig {params(event: Event).returns(String)}
  def header_image_url(event)
    index = event.id.chars.map(&:ord).sum
    EVENT_HEADER_IMAGE_URLS[index % EVENT_HEADER_IMAGE_URLS.length]
  end

  sig {params(event: Event).returns(String)}
  def event_location_query(event)
    event.place_id? ? "place_id:#{event.place_id}" : event.location
  end

  sig {params(event: Event).returns(String)}
  def google_maps_location_url(event)
    "https://maps.google.com?q=#{event_location_query(event)}"
  end

  sig {params(event: Event).returns(String)}
  def google_maps_embed_url(event)
    "https://www.google.com/maps/embed/v1/place?key=#{Config.google_maps_embed_key}&q=#{event_location_query(event)}"
  end
end

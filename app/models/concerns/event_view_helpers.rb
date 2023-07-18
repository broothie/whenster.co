# typed: true
module EventViewHelpers
  extend T::Sig
  extend ActiveSupport::Concern

  EVENT_HEADER_IMAGE_URLS = [
    # Yellow abstract
    "https://img.freepik.com/free-vector/hand-drawn-abstract-doodle-pattern-design_23-2149268666.jpg",
    # Confetti
    "https://images.unsplash.com/photo-1513151233558-d860c5398176?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
    # White bokeh lights
    "https://images.unsplash.com/photo-1519751138087-5bf79df62d5b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
    # Pink + white
    "https://images.unsplash.com/photo-1546050680-d4305dcff705?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3432&q=80",
  ].freeze

  sig {returns(String)}
  def header_image_url
    index = id.chars.map(&:ord).sum
    EVENT_HEADER_IMAGE_URLS[index % EVENT_HEADER_IMAGE_URLS.length]
  end

  sig {returns(String)}
  def google_maps_location_url
    "https://maps.google.com?q=#{location_query}"
  end

  sig {returns(String)}
  def google_maps_embed_url
    "https://www.google.com/maps/embed/v1/place?key=#{Config.google_maps_embed_key}&q=#{location_query}"
  end

  private

  sig {returns(String)}
  def location_query
    place_id? ? "place_id:#{place_id}" : location
  end
end

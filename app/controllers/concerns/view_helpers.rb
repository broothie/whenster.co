module ViewHelpers
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

  # @param user [User]
  # @return [String]
  def user_calendar_url(user)
    Service.base_url("calendar", user.calendar_token)
  end

  # @param user [User]
  # @return [String]
  def gravatar_url(user)
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?d=retro"
  end

  # @param file [Object]
  # @param fallback [String]
  # @return [String]
  def file_url(file, fallback)
    file.present? ? url_for(file) : fallback
  end

  # @param event [Event]
  # @return [String]
  def header_image_url(event)
    index = event.id.chars.map(&:ord).sum
    EVENT_HEADER_IMAGE_URLS[index % EVENT_HEADER_IMAGE_URLS.length]
  end
end

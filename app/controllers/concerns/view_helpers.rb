module ViewHelpers
  # @param user [User]
  # @return [String]
  def user_calendar_url(user)
    Service.base_url("calendar", user.calendar_token)
  end

  # @param user [User]
  # @param variant [Symbol, NilClass]
  # @return [String]
  def user_image_url(user, variant = nil)
    if user.image.attached?
      image = variant ? user.image.variant(variant) : user.image
      url_for(image)
    else
      gravatar_url(user)
    end
  end

  # @param user [User]
  # @return [String]
  def gravatar_url(user)
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?d=retro"
  end
end

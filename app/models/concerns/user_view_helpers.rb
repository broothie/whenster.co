# typed: true
module UserViewHelpers
  extend T::Sig
  extend ActiveSupport::Concern

  sig {returns(String)}
  def calendar_url
    Config.base_url("calendar", "#{calendar_token}.ics")
  end

  sig {returns(String)}
  def gravatar_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?d=retro"
  end
end

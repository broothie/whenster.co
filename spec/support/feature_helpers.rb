# typed: true
module FeatureHelpers
  extend T::Sig

  sig {params(user: User).void}
  def log_in(user)
    visit "/login/#{user.login_links.create.token}"
  end
end

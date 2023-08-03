# typed: true
module FeatureHelpers
  extend T::Sig

  sig {params(user: User).void}
  def log_in(user)
    visit "/login/#{user.login_links.create.token}"
    expect(page).to have_content user.username
  end
end

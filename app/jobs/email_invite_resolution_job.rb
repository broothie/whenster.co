# typed: true
class EmailInviteResolutionJob
  extend T::Sig
  include Sidekiq::Job

  sig {params(user_id: String, email_invite_id: T.nilable(String)).void}
  def perform(user_id, email_invite_id = nil)
    user = User.find(user_id)
    return perform_dispatch(user) unless email_invite_id

    email_invite = EmailInvite.find(email_invite_id)
    perform_resolution(user, email_invite)
  end

  private

  sig {params(user: User).void}
  def perform_dispatch(user)
    EmailInvite.where("email ILIKE ?", user.email).pluck(:id).each do |email_invite_id|
      EmailInviteResolutionJob.perform_async(user.id, email_invite_id)
    end
  end

  sig {params(user: User, email_invite: EmailInvite).void}
  def perform_resolution(user, email_invite)
    ActiveRecord::Base.transaction do
      Invite.create!(
        event: email_invite.event,
        user: user,
        inviter: email_invite.inviter,
        skip_created_email: true,
      )

      email_invite.destroy!
    end
  end
end

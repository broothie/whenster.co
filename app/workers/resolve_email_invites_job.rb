# typed: true
class ResolveEmailInvitesJob
  extend T::Sig
  include Cloudtasker::Worker

  sig {params(user_id: String).void}
  def perform(user_id)
    user = User.find(user_id)
    email_invites = EmailInvite.where_email(user.email).eager_load(:invite)

    email_invites.each do |email_invite|
      invite = user.invites.new(
        event_id: email_invite.event_id,
        inviter_id: email_invite.inviter_id,
        role: email_invite.role,
        skip_created_email: true,
      )

      if invite.save
        email_invite.destroy
      else
        log.error "failed to create invite for email_invite #{email_invite.id}: #{invite.errors.full_messages}"
      end
    end
  end
end

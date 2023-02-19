# frozen_string_literal: true
# https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # Users
    can :read, User
    can :manage, User, id: user.id

    # Invites
    can :create, Invite, event: { invites: { user: user, role: :host } }
    can :update, Invite, :status, user: user
    can :update, Invite, :role, event: { invites: { user:, role: :host } }

    # Email invites
    can :create, EmailInvite, event: { invites: { user: user, role: :host } }

    # Events
    can :create, Event
    can :read, Event, invites: { user: user }
    can :manage, Event, invites: { user: user, role: :host }

    # Posts
    can :create, Post, event: { invites: { user: user } }
    can :manage, Post, user: user
    can :destroy, Post, event: { invites: { user: user, role: :host } }

    # Comments
    can :create, Comment, event: { invites: { user: user } }
    can :manage, Comment, user: user
    can :destroy, Comment, post: { user: user }
    can :destroy, Comment, event: { invites: { user: user, role: :host } }
  end
end

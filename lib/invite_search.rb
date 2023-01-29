# typed: true
class InviteSearch
  extend T::Sig

  sig {params(event: Event, username_query: String, limit: Integer).returns(ActiveRecord::Relation)}
  def self.search(event, username_query, limit: 25)
    new(event, username_query).search(limit:)
  end

  sig {params(event: Event, username_query: String).void}
  def initialize(event, username_query)
    @event = event
    @username_query = username_query
  end

  sig {params(limit: Integer).returns(ActiveRecord::Relation)}
  def search(limit: 25)
    User
      .joins(join)
      .where("invites.id": nil)
      .where("username ILIKE ?", fuzzy_username_query)
      .limit(limit)
  end

  private

  sig {returns(String)}
  def fuzzy_username_query
    "%#{@username_query.chars.join("%")}%"
  end

  sig {returns(T.any(Arel::Nodes::InnerJoin, Arel::Nodes::OuterJoin))}
  def join
    users_table.create_join(invites_table, on, Arel::Nodes::OuterJoin)
  end

  sig {returns(Arel::Nodes::Equality)}
  def predicate
    invites_table[:event_id].eq(@event.id)
  end

  sig {returns(Arel::Nodes::On)}
  def on
    users_table.create_on(users_table[:id].eq(invites_table[:user_id]).and(predicate))
  end

  sig {returns(Arel::Table)}
  def users_table
    @users_table ||= User.arel_table
  end

  sig {returns(Arel::Table)}
  def invites_table
    @invites_table ||= Invite.arel_table
  end
end

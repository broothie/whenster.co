extend T::Sig

sig {params(user: User).returns(JWTSessions::Session)}
def jwt_session(user)
  JWTSessions::Session.new(payload: { user_id: user.id })
end

sig {params(user: User).returns(Hash)}
def auth_headers(user)
  { Authorization: "Bearer #{jwt_session(user).login.fetch(:access)}" }
end

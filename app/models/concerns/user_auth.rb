# typed: true
module UserAuth
  extend T::Sig
  extend ActiveSupport::Concern

  sig {returns(String)}
  def generate_jwt
    JWT.encode({ id:, exp: 30.days.from_now.to_i }, Config.secret)
  end
end

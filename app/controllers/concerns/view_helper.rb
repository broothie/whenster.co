# typed: true
module ViewHelper
  extend T::Sig

  sig {params(file: T.untyped, fallback: String).returns(String)}
  def file_url(file, fallback)
    file.present? ? url_for(file) : fallback
  end
end

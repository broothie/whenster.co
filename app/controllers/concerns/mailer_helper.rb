# typed: true
module MailerHelper
  extend T::Sig
  extend ActiveSupport::Concern

  delegate :base_url, to: Config

  sig {params(markdown: String).returns(String)}
  def markdown(markdown)
    @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true), autolink: true)

    @markdown_renderer.render(markdown).html_safe
  end

  sig {returns(T.nilable(String))}
  def public_css_filename
    filepath = Dir.glob("public/index-*.css").first
    return nil unless filepath

    File.basename(filepath)
  end

  sig {returns(String)}
  def long_time_format
    "%A, %B %e, %l%P %Z"
  end
end

module Tiptap
  extend T::Sig

  sig {params(markdown: String).returns(String)}
  def self.json_from_markdown(markdown)
    Tempfile.create do |file|
      json_filename = "#{file.path}.json"

      file.write(markdown)
      file.close
      `node bin/markdown_to_tip_tap.js #{file.path} > #{json_filename}`

      File.read(json_filename)
    end
  end
end

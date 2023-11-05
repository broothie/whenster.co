namespace :tiptap do
  desc "Migrates all markdown texts in the db to Tiptap"
  task migrate: :environment do
    {
      Event => [:description],
      Post => [:body],
      Comment => [:body],
    }.each do |model, fields|
      model.all.each do |record|
        fields.each do |field|
          puts "--------------------"
          puts "#{record.id}: #{model}.#{field}"

          markdown = record[field]
          tiptap_json = Tiptap.json_from_markdown(markdown)
          puts "markdown: #{markdown}"
          puts "json: #{tiptap_json}"

          record[field] = tiptap_json
          record.save(validate: false)
        end
      end
    end
  end
end

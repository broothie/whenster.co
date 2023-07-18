require 'google/cloud/firestore'
require 'google/cloud/storage'

env = Config.deploy_env
env = "development" if env == "local"

collection_name = "whenster.#{env}"
bucket_name = "whenster-#{env}-images"

puts "using collection '#{collection_name}' and bucket '#{bucket_name}'"
print "proceed? (y/n): "
exit 1 unless gets.chomp == "y"

firestore = Google::Cloud::Firestore.new(project_id: "whensterco", credentials: Rails.root.join(".local/old.gcloud.key.json"))
old_storage = Google::Cloud::Storage.new(project_id: "whensterco", credentials: Rails.root.join(".local/old.gcloud.key.json"))
old_bucket = old_storage.bucket(bucket_name)

collection = firestore.collection(collection_name)
old_users = collection.where("type", "==", "user")
old_events = collection.where("type", "==", "event")
old_posts = collection.where("type", "==", "post")
old_comments = collection.where("type", "==", "comment")

user_map = {}.with_indifferent_access
old_users.get do |old_user|
  user_id = old_user[:user_id]
  puts "user #{user_id}"

  new_user = User.create!(
    username: old_user[:username],
    email: old_user[:email],
    timezone: old_user[:timezone],
    calendar_token: old_user[:calendar_token],
  )

  image_id = old_user[:image_id]
  if image_id.present?
    puts "user #{user_id} image"
    local_filename = ".local/migrate_images/#{image_id}"

    old_image_file = old_bucket.file(image_id)
    file = old_image_file.download(local_filename)

    new_user.image.attach(io: file, filename: image_id)
  end

  user_map[user_id] = new_user
  puts "user #{old_user[:user_id]} done"
end

event_map = {}.with_indifferent_access
invite_map = {}.with_indifferent_access
old_events.get do |old_event|
  old_event_id = old_event[:event_id]
  puts "event #{old_event_id}"

  new_event = Event.new(
    title: old_event[:title],
    description: old_event[:description],
    start_at: old_event[:start_time],
    end_at: old_event[:end_time],
    location: old_event[:location],
    place_id: old_event[:place_id],
  )

  new_event.save!(validate: false)
  event_map[old_event_id] = new_event

  image_id = old_event[:header_image_id]
  if image_id.present?
    puts "event #{old_event_id} header image"
    local_filename = ".local/migrate_images/#{image_id}"

    old_image_file = old_bucket.file(image_id)
    file = old_image_file.download(local_filename)

    new_event.header_image.attach(io: file, filename: image_id)
  end

  old_event[:invites].each do |user_id, old_invite|
    puts "event #{old_event_id} invite for user #{user_id}"

    new_invite = Invite.new(
      user: user_map[user_id],
      event: new_event,
      inviter: user_map[old_invite[:inviter_id]],
      role: old_invite[:role],
      status: old_invite[:status]
    )

    new_invite.save!(validate: false)

    invite_map[[old_event_id.to_s, user_id.to_s]] = new_invite

    puts "event #{old_event_id} invite for user #{user_id} done"
  end

  puts "event #{old_event_id} done"
end

posts_map = {}.with_indifferent_access
old_posts.get do |old_post|
  old_post_id = old_post[:post_id]
  puts "post #{old_post_id}"

  next unless event_map[old_post[:event_id]]
  next unless invite_map[[old_post[:event_id].to_s, old_post[:user_id].to_s]]

  new_post = Post.create!(
    event: event_map[old_post[:event_id]],
    invite: invite_map[[old_post[:event_id].to_s, old_post[:user_id].to_s]],
    body: old_post[:body],
  )

  posts_map[old_post_id] = new_post

  old_post[:image_ids]&.each_with_index do |image_id, index|
    puts "post #{old_post_id} image #{index}"
    local_filename = ".local/migrate_images/#{image_id}"

    old_image_file = old_bucket.file(image_id)
    file = old_image_file.download(local_filename)

    new_post.images.attach(io: file, filename: image_id)
  end

  puts "post #{old_post_id} done"
end

old_comments.get do |old_comment|
  old_comment_id = old_comment[:comment_id]
  puts "comment #{old_comment_id}"

  return unless invite_map[[old_comment[:event_id].to_s, old_comment[:user_id].to_s]]
  return unless posts_map[old_comment[:post_id]]

  new_comment = Comment.create!(
    invite: invite_map[[old_comment[:event_id].to_s, old_comment[:user_id].to_s]],
    post: posts_map[old_comment[:post_id]],
    body: old_comment[:body],
  )

  old_comment[:image_ids]&.each_with_index do |image_id, index|
    puts "comment #{old_comment_id} image #{index}"
    local_filename = ".local/migrate_images/#{image_id}"

    old_image_file = old_bucket.file(image_id)
    file = old_image_file.download(local_filename)

    new_comment.images.attach(io: file, filename: image_id)
  end

  puts "comment #{old_comment_id} done"
end

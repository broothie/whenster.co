# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

namespace "dev" do
  desc "set up docker containers for dbs"
  task "resources" do
    sh "docker compose up -d"
  end
end

class RootController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render file: Rails.root.join("public", "index.html")
  end

  def healthz
  end
end

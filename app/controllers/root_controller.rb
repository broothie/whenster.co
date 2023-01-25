class RootController < ApplicationController
  def index
    render file: "public/index.html"
  end

  def healthz
  end
end

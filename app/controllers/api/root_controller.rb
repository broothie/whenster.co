class Api::RootController < ApplicationController
  skip_before_action :authenticate_user!

  def health
    head :ok
  end

  def info
  end
end

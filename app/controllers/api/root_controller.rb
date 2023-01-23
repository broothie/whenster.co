class Api::RootController < ApplicationController
  def health
    head :ok
  end

  def info
  end
end

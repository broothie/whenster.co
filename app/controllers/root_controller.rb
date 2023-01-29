class RootController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render file: Rails.root.join("public", "index.html")
  end

  def healthz
    TestWorker.perform_async
  end

  def calendar
    user = User.find_by(calendar_token: params[:token])

    render body: ICalendar.new(user), content_type: 'text/calendar'
  end
end

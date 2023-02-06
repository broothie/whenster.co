class RootController < ApplicationController
  skip_before_action :authorize_access_request!
  skip_authorization_check

  def index
    render file: Rails.root.join("public", "index.html")
  end

  def info
  end

  def calendar
    user = User.find_by(calendar_token: params[:token])

    render body: ICalendar.new(user), content_type: 'text/calendar'
  end
end

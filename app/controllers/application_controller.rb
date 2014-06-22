class ApplicationController < ActionController::Base

  protected
  # Override this with a better way to get the current Wink user when we have it
  def current_wink_user_id
    request.env['auth.wink.user_id']
  end
end

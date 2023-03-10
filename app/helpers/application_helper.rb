module ApplicationHelper
  require 'digest'
  def current_user
    return unless session[:user_id]
    @user ||= User.find(session[:user_id])
  end

end

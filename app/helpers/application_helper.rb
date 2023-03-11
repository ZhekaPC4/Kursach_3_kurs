module ApplicationHelper
  require 'digest'

  def current_user
    return unless session[:user_id]
    @user ||= User.find(session[:user_id])
  end

  def hash_password(salt, password)
    hashed_password = Digest::SHA512.hexdigest(salt + "kekWkekW" + password.to_s)
    return Digest::SHA512.hexdigest(hashed_password + "Say_my_name")
  end
  
end
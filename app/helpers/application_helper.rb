module ApplicationHelper
  require 'digest'

  def current_user
    return unless session[:user_id]
    user ||= User.find(session[:user_id])
  end

  def hash_password(salt, password)
    hashed_password = Digest::SHA512.hexdigest(salt + "I_am_the_danger" + password.to_s)
    return Digest::SHA512.hexdigest(hashed_password + "Say_my_name")
  end

  def is_employee_return
    if !current_user.present?
      redirect_to user_login_path and return false
    elsif current_user.role_id != 2
      redirect_to main_page_path and return false
    end
  end

  def is_employee
    if !current_user.present?
      return false
    elsif current_user.role_id != 2
      return false
    end
    return true
  end

  def is_employee_or_admin_return
    if !current_user.present?
      redirect_to user_login_path and return false
    end
    unless current_user.role_id == 2 || current_user.role_id == 1
      redirect_to main_page_path and return false
    end
  end

  def is_employee_or_visitor_return
    if !current_user.present?
      redirect_to user_login_path and return false
    end
    unless current_user.role_id == 2 || current_user.role_id == 3
      redirect_to main_page_path and return false
    end
  end

  def is_visitor_return
    if !current_user.present?
      redirect_to user_login_path and return false
    elsif current_user.role_id != 3
      redirect_to main_page_path and return false
    end
  end

  def is_visitor
    if !current_user.present?
      return false
    elsif current_user.role_id != 3
      return false
    end
    return true
  end

  def is_user_or_admin
    unless session[:user_id].to_s == params[:id] || current_user.role_id == 1
      redirect_to main_page_path and return false
    end
    return true
  end


  def is_admin
    if current_user.role_id != 1
      redirect_to main_page_path
    end
  end

  def check_is_admin
    if current_user.role_id != 1
      return false
    end
    return true
  end

  def is_current_user
    if session[:user_id].to_s != params[:id]
      return false
    end
    return true
  end

  def user_present
    unless current_user.present?
      redirect_to user_login_path
    end
  end

end
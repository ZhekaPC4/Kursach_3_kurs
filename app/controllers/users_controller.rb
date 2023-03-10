class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end    

  def log_out
    session[:user_id] = nil
    redirect_to user_login_path
  end

  def auth
    @user = User.find_by(login: user_params[:login], password: user_params[:password])
    if @user.present?
      session[:user_id] = @user.id
      redirect_to user_path(id: @user.id)
    else
      flash[:error] = "Неверные логин или пароль"
      redirect_to user_login_path
    end
  end

  def render_not_found
    render :file => "#{Rails.root}/public/404.html",  :status => 404
  end

  def show
    @user = User.find_by(id: params[:id])
    if not @user.present?
      render_not_found
    elsif session[:user_id] != @user.id
      redirect_to main_page_path
    end
    rescue ActiveRecord::RecordNotFound
      render_not_found
  end

  def new
  end

  def login
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(id: @user.id)
    else
      flash[:reg_error] = @user.password
      redirect_to user_new_path
    end
  end
  
  private
  def user_params
    new_params = params.require(:user).permit(:name, :login, :password, :password_confirmation)
    new_params[:password] = coding(new_params[:login], new_params[:password])
    new_params[:password_confirmation] = coding(new_params[:login], new_params[:password_confirmation])
    new_params.permit!
  end

  def coding(salt, password)
    hash_password = Digest::SHA512.hexdigest(salt + "kekWkekW" + password.to_s)
    return Digest::SHA512.hexdigest(hash_password + "Say_my_name")
  end

end
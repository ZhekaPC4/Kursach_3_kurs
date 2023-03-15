class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    elsif session[:user_id] != @user.id && current_user.role != "admin"
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

  def all
    if !current_user.present?
      redirect_to main_page_path
    elsif current_user.role != "admin"
      redirect_to main_page_path
    else
      @users = User.all
    end 

  end

  def edit
    @user = User.find_by(id: params[:id])
    if session[:user_id] != @user.id && current_user.role != "admin"
      redirect_to main_page_path
    end
  end

  def edited
    @user = User.find_by(id: params[:id])
    if current_user.password != user_change_params[:password_old] 
      flash[:error] = "Неверный пароль"
      redirect_to user_edit_path(@user.id)
    else
      if user_change_params[:change_pass] == "true"
        @user.update_columns(login: user_change_params[:login], name: user_change_params[:name], password: user_change_params[:password])
      else 
        @user.update_columns(login: user_change_params[:login], name: user_change_params[:name])
      end
      if @user.save && current_user.role == "admin" 
        @user.update_columns(role: user_change_params[:role])
      end
      if @user.save
        redirect_to user_path(@user.id)
      else 
        flash[:edit_error] = "Ошибка изменения"
        redirect_to user_edit_path(@user.id)
      end
    end
  end

  private
  def user_params
    new_params = params.require(:user).permit(:name, :login, :password, :password_confirmation)
    new_params[:password] = hash_password(new_params[:login], new_params[:password])
    new_params[:password_confirmation] = hash_password(new_params[:login], new_params[:password_confirmation])
    new_params.permit!
  end

  def user_change_params
    new_params = params.require(:user).permit(:name, :login, :password, :password_confirmation, :password_old,:change_pass, :role)
    new_params[:password] = hash_password(new_params[:login], new_params[:password])
    new_params[:password_confirmation] = hash_password(new_params[:login], new_params[:password_confirmation])
    new_params[:password_old] = hash_password(current_user.login, new_params[:password_old])
    new_params.permit!
  end


end
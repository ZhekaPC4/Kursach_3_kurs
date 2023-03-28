class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_user_or_admin, only: [:show, :edit, :update, :delete]
  before_action :is_admin, only: [:index]

  def log_out
    session[:user_id] = nil
    redirect_to user_login_path
  end

  def auth
    @user = User.find_by(login: user_params[:login], password: hash_password(user_params[:login], user_params[:password]))
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

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if current_user.password != user_change_params[:password_old] 
      flash[:update_error] = "Неверный пароль"
      redirect_to user_edit_path(@user.id) and return
    else
      if user_change_params[:change_pass]
        @user.update({login: user_change_params[:login], name: user_change_params[:name], password: user_change_params[:password]})
      else 
        @user.update({login: user_change_params[:login], name: user_change_params[:name], password: user_change_params[:password_old_unhashed]})
      end
      if @user.save && current_user.role == "admin"
        @user.update({role: user_change_params[:role]})
      end
      if @user.save
        redirect_to user_path(@user.id) and return
      else 
        flash[:update_error] = "Ошибка изменения"
        redirect_to user_edit_path(@user.id)
      end
    end
  end

  def delete
    @user = User.find_by(id: params[:id])
    if !check_is_admin
      session[:user_id] = nil
      path = main_page_path
    else 
      path = user_index_path
    end
    @user.destroy
    redirect_to path and return
  end

  private
  def user_params
    new_params = params.require(:user).permit(:name, :login, :password, :password_confirmation)
    new_params.permit!
  end

  def user_change_params
    new_params = params.require(:user).permit(:name, :login, :password, :password_confirmation, :password_old,:change_pass, :role, :password_old_unhashed)
    new_params[:password_old_unhashed] = new_params[:password_old];
    new_params[:password_old] = hash_password(current_user.login, new_params[:password_old])
    new_params.permit!
  end

end
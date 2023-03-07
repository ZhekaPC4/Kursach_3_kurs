class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end
      

  def log_out
    session[:user_id] = nil
    redirect_to user_page_path
  end


  def auth
      @user = User.find_by(login: params[:alogin], password: params[:apassword])
      if @user.present?
        session[:user_id] = @user.id
        redirect_to user_path(id: @user.id)
      else
        flash[:error] = "Неверный логин или пароль"
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
      redirect_to user_page_path
    end
    rescue ActiveRecord::RecordNotFound
      render_not_found
  end


  def new
  end

  def login
  end
  
  def create
    @user = User.find_by(login: params[:login])
    if @user.present?
        flash[:reg_error] = "Логин уже используется"
        redirect_to user_new_path
    else
        if params[:password] != params[:password2]
          flash[:reg_error] = "Пароли не совпадают"
          redirect_to user_new_path
        else
          @user = User.new
          @user.login = params[:login]
          @user.password = params[:password]
          @user.name = params[:name]
          if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(id: @user.id)
          else
            flash[:reg_error] = "Ошибка сохранения"
            redirect_to user_new_path
          end
        end
    end
  end
end
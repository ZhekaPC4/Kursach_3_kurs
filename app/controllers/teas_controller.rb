class TeasController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_employee_return, except: [:index, :show]
  
  def index
    @teas = Tea.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @tea = Tea.find(params[:id])
  end
  
  def new
  end

  def create
    @tea = Tea.new(tea_params)
    if @tea.save
      redirect_to tea_by_id_path(@tea.id)
    else 
      flash[:new_tea_error] = "Слишком короткое название или описание чая"
      redirect_to tea_new_path
    end
  end

  def delete
    @tea = Tea.find(params[:id])
    @tea.destroy
    redirect_to main_page_path
  end

  def edit
    @tea = Tea.find(params[:id])
  end

  def update
    @tea = Tea.find(params[:id])
    @tea.update(tea_params)
    if @tea.save
      redirect_to main_page_path
    else 
      redirect_to tea_edit_path
      flash[:edit_error] = "Ошибка изменения"
    end
  end
  
  def cms
    @teas = Tea.order(id: :desc).page(params[:page]).per(15)
  end

  private
  def tea_params
    new_params = params.require(:tea).permit(:name, :price, :weight, :description)
  end

end

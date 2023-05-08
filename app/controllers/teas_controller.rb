class TeasController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_employee_return, except: [:index, :show, :addtocart]
  before_action :user_present, only: [:addtocart]
  
  def index
    @teas = Tea.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @tea = Tea.find(params[:id])
  end
  
  def new
  end

  def addtocart
    if !current_user.orders.present? || Status.where(order_id: current_user.orders.last.id).last.current_status != "Bucket"
      Order.create!(user_id: current_user.id, delivery_data: "temp_info", total_price: 1)
      Status.create(order_id: current_user.orders.last.id, current_status: "Bucket")
      OrderedTea.create(order_id: current_user.orders.last.id, tea_id: params[:id], amount: 1)
    elsif OrderedTea.find_by(order_id: current_user.orders.last.id, tea_id: params[:id]).present?
      ord_tea = OrderedTea.find_by(order_id: current_user.orders.last.id, tea_id: params[:id])
      ord_tea.update({amount: ord_tea.amount + 1})
    else
      OrderedTea.create(order_id: current_user.orders.last.id, tea_id: params[:id], amount: 1)
    end
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

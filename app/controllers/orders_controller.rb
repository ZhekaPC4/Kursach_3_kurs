class OrdersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :user_present, only: [:bucket, :create, :index, :status]
    before_action :is_employee_return, only: [:new_status]

    def index
        if is_employee 
            @orders = Order.where(id: Order.all.reject { |order| order.statuses.last.current_status == "Bucket" }.map(&:id)).order(id: :desc).page(params[:page]).per(10)
        else
            @orders = Order.where(user_id: current_user.id, id: Order.all.reject { |order| order.statuses.last.current_status == "Bucket" }.map(&:id)).order(id: :desc).page(params[:page]).per(10)
        end
    end

    def bucket
        @order = nil
        if current_user.orders.present? && Status.where(order_id: current_user.orders.last.id).last.current_status == "Bucket"
            @order = current_user.orders.last
            @orders = OrderedTea.where(order_id: @order.id)
        end
    end

    def create
        if current_user.delivery_data.present?
            sum_price = 0
            order = current_user.orders.last
            orders = OrderedTea.where(order_id: order.id)
            orders.each do |orderedTea|
                orderedTea.update({price_during_order: orderedTea.tea.price})
                sum_price += orderedTea.tea.price
            end
            order.update({delivery_data: current_user.delivery_data, total_price: sum_price})
            Status.create(order_id: current_user.orders.last.id, current_status: "Placed")
        else
            flash[:order_error] = "Пожалуйста, заполните данные доставки"
        end
        redirect_to order_bucket_path
    end

    def status
        @order = Order.find(params[:id])
    end

    def new_status
        stat = Status.new(current_status: params[:current_status], status_commentary: params[:status_commentary], order_id: params[:id])
        unless stat.save
            flash[:status_error] = "Проверьте введенные данные"
        end
        redirect_to order_status_path(params[:id])
    end
end
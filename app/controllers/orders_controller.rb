class OrdersController < ApplicationController
    before_action :user_present, only: [:bucket, :create, :index]

    def index
        if is_employee 
            @orders = Order.where(id: Order.all.reject { |order| order.statuses.last.current_status == "Bucket" }.map(&:id))
        else
            @orders = Order.where(user_id: current_user.id, id: Order.all.reject { |order| order.statuses.last.current_status == "Bucket" }.map(&:id))
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

end
class OrdersController < ApplicationController
    before_action :user_present, only: [:bucket, :create, :index]

    def index
        @orders = nil
        if is_employee 
            @orders = Order.where(user_id: current_user.id)
            #затычка
            stas = Status.all
            stas.each do |record|
                if record.current_status != "Bucket" && (!@order.present? || !@order.include(Order.find(record.order_id)))
                    @orders = @orders && Order.find(record.order_id)
                end
            end
            #конец затычки
        else
            #затычка
            stas = Status.all
            stas.each do |record|
                if record.order.user_id != current_user.id && record.current_status != "Bucket" && !@order.include?(Order.find(record.order_id))
                    @orders = @orders && Order.find(record.order_id)
                end
            end
            #конец затычки
        end
    end

    def bucket
        @order = nil
        if current_user.orders.present? && Status.find_by(order_id: current_user.orders.last.id).current_status == "Bucket"
            @order = current_user.orders.last
            @orders = OrderedTea.where(order_id: @order.id)
        end
    end

    def create
        if current_user.delivery_data.present
            sum_price = 0
            order = current_user.order.last
            orders = OrderedTea.where(order_id: @order.id)
            orders.each do |orderedTea|
                orderedTea.update({price_during_order: orderedTea.tea.price})
                sum_price += orderedTea.tea.price
            end
            order.update({delivery_data: current_user.delivery_data, total_price: sum_price})
            Status.create(order_id: current_user.orders.last.id, current_status: "Placed")
        else
            flash[:order_error] = "Пожалуйста, заполните данные доставки"
        end
    end

end
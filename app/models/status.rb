class Status < ApplicationRecord
    validates :current_status, length: { minimum: 3 }
    belongs_to :order, foreign_key: :order_id, class_name: "Order"
end
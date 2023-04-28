class OrderedTea < ApplicationRecord
    belongs_to :order, foreign_key: :order_id, class_name: "Order"
    belongs_to :tea, foreign_key: :tea_id, class_name: "Tea"
end
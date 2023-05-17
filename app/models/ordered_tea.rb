class OrderedTea < ApplicationRecord
    belongs_to :order, foreign_key: :order_id, class_name: "Order"
    belongs_to :tea, foreign_key: :tea_id, class_name: "Tea"

    after_update :ensure_there_is_smth

    def ensure_there_is_smth
        if self.amount <= 0
            self.destroy
            if !self.order.ordered_teas.present?
                self.order.destroy
            end
        end
    end
end
class Order < ApplicationRecord
    validates :delivery_data, length: { minimum: 5 }
    belongs_to :user, foreign_key: :user_id, class_name: "User"
    has_many :statuses, dependent: :destroy, foreign_key: :status_id
    has_many :ordered_teas, dependent: :destroy, foreign_key: :ordered_tea_id
end
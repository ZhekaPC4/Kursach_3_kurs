class Tea < ApplicationRecord
    validates :name, length: { minimum: 4 }, uniqueness: {message: "это имя уже занято"}
    has_many :oredered_teas, dependent: :destroy, foreign_key: :ordered_tea_id
end
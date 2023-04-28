class Tea < ApplicationRecord
    validates :name, length: { minimum: 4 }, uniqueness: {message: "это имя уже занято"}
    validates :weight, length: { minimum: 4 }
end
class User < ApplicationRecord
    validates :login, length: { minimum: 4 }, uniqueness: {message: "Такой логин уже существует"}
    validates :name, length: { minimum: 2 }
    validates :password, length: { minimum: 6 }, confirmation: true
    has_many :articles

end

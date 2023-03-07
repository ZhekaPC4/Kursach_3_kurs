class User < ApplicationRecord
    validates :login, length: { minimum: 4 }
    validates :name, length: { minimum: 2 }
    validates :password, length: { minimum: 6 }
    has_many :articles
end

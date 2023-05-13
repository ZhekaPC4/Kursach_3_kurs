class User < ApplicationRecord
    before_save :hash_the_password, if: :password_changed?

    has_many :orders, dependent: :destroy, foreign_key: :user_id
    belongs_to :role, foreign_key: :role_id, class_name: "Role"
    validates :login, length: { minimum: 4 }, uniqueness: {message: "Такой логин уже существует"}
    validates :name, length: { minimum: 2 }
    validates :password, length: { minimum: 6 }, confirmation: true


    private
    def hash_the_password()
        hashed_password = Digest::SHA512.hexdigest(self.login + "I_am_the_danger" + self.password)
        self.password = Digest::SHA512.hexdigest(hashed_password + "Say_my_name")
    end
        
    def password_changed?()
        return changed.include? "password"
    end
end
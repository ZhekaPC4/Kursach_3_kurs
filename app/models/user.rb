class User < ApplicationRecord
  before_save :hash_the_password, if: :password_changed?
  # before_create :update_hash_the_password


  validates :login, length: { minimum: 4 }, uniqueness: {message: "Такой логин уже существует"}
  validates :name, length: { minimum: 2 }
  validates :password, length: { minimum: 6 }, confirmation: true
  has_many :articles, dependent: :destroy, foreign_key: :author_id

  private
  def hash_the_password()
    hashed_password = Digest::SHA512.hexdigest(self.login + "kekWkekW" + self.password)
    self.password = Digest::SHA512.hexdigest(hashed_password + "Say_my_name")
  end
    
  def password_changed?()
    return changed.include? "password"
  end
end

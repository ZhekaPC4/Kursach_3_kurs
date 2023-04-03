include ApplicationHelper
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :login, length: {minimum: 4}, presence: true, null: false, unique: true
      t.string :name, length: {minimum: 2}, presence: true, null: false
      t.string :password, length: {minimum: 6}, presence: true, null: false
      t.string :role, presence: true, null: false, default: "visitor"
      t.timestamps
    end
    
    User.create(login: "1234567890", password: "1234567890", name: "1234567890", role: "admin")
  end
end

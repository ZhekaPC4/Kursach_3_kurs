class AddUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :login, length: {minimum: 4}, presence: true, null: false, unique: true
      t.string :password, length: {minimum: 6}, presence: true, null: false
      t.string :name, length: {minimum: 2}, presence: true, null: false
      t.string :surname, length: {minimum: 2}
      t.string :lastname, length: {minimum: 2}
      t.string :delivery_data, length: {minimum: 5}
      t.references :role, foreign_key: {to_table: :roles}, null: false, default: 3
    end
    
    User.create(login: "1234567890", password: "1234567890", password_confirmation: "1234567890", name: "Василий", surname: "Алибабаевич", role_id: 1)
  end
end

class AddTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.integer :price, presence: true, null: false
      t.string :name,  length: {minimum: 4}, presence: true, null: false, unique: true
      t.string :description
      t.integer :weight, presence: true, null: false
    end
  end
end

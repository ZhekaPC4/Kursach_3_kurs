class AddOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :delivery_data, length: {minimum: 5}
      t.float :total_price
      t.references :user, foreign_key: {to_table: :users}
    end
  end
end

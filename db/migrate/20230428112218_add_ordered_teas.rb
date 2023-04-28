class AddOrderedTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :ordered_teas do |t|
      t.integer :amount
      t.float :price_during_order
    
      t.references :order, foreign_key: {to_table: :orders}
      t.references :tea, foreign_key: {to_table: :teas}
    end
  end
end

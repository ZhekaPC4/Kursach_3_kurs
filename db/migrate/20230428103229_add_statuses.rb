class AddStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :statuses do |t|
      t.string :current_status, length: {minimum: 5}
      t.string :status_commentary
      t.references :order, foreign_key: {to_table: :orders}
      t.timestamps
    end
  end
end

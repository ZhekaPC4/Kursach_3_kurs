class CreateArticles < ActiveRecord::Migration[7.0]
    def change
      create_table :articles do |t|
        t.references :author, foreign_key: {to_table: :users}
        t.string :title, length: {minimum: 2}, presence: true, null: false, unique: true
        t.string :text, length: {minimum: 6}, presence: true, null: false
      end
    end
  end
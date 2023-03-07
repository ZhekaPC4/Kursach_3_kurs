class Article < ApplicationRecord
    belongs_to :author, foreign_key: :author_id, class_name: "User"
    validates :title, length: { minimum: 6 }
    validates :text, length: { minimum: 6 }
end
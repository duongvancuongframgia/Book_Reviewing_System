class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: {maximum: 150}
  validates :content, presence: true
end

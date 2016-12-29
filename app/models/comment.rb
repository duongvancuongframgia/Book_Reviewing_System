class Comment < ApplicationRecord
  default_scope -> {order(created_at: :desc)}

  belongs_to :user
  belongs_to :review

  validates :content, presence: true
end

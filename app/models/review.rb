class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_many  :comments, dependent: :destroy
  has_many :passive_likes, class_name: Like.name, foreign_key: :review_id, dependent: :destroy
  has_many :likers, through: :passive_likes, source: :user

  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true
  validates :book_id, presence: true
  validates :user_id, presence: true
end

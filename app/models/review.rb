class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many  :comments, dependent: :destroy
  has_many  :comments

  validates :title, presence: true, length: {maximum: Settings.max_len_name}
  validates :content, presence: true
  validates :book_id, presence: true
  validates :user_id, presence: true

  scope :newest, ->{order created_at: :desc}
end

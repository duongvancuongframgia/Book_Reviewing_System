class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :user_id, uniqueness: {scope: :book_id}
end

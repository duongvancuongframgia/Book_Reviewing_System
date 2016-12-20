class Request < ApplicationRecord
  belongs_to :user

  validates :book_title, presence: true, length: {maximum: 100}
  validates :user_id, presence: true
end

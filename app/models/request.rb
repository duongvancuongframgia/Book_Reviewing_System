class Request < ApplicationRecord
  belongs_to :user

  validates :book_title, presence: true, length: {maximum: Settings.max_len_name}
  validates :user, presence: true

  enum status: [ :pending, :sent, :approved, :reject ]
end

class Request < ApplicationRecord
  belongs_to :user

  validates :book_title, presence: true,
    length: {maximum: Settings.max_len_name}
  validates :user_id, presence: true
end

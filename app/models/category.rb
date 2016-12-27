class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: { maximum: Settings.max_len_name },
    uniqueness: true
end

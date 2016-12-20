class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
end

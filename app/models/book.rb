class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :passive_rates, class_name: Rate.name, foreign_key: :book_id, dependent: :destroy
  has_many :raters, through: :passive_rates, source: :user

  VALID_DATE_REGEX = /\A\d{4}\-(?:0?[1-9]|1[0-2])\-(?:0?[1-9]|[1-2]\d|3[01])\z/i
  validates :title, presence: true, length: {maximum: 100}, uniqueness: true
  validates :description, presence: true
  validates :publish_date, presence: true, format: { with: VALID_DATE_REGEX}
  validates :author, presence: true
end

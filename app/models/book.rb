class Book < ApplicationRecord
	# relationship of table
	belongs_to :category
	has_many :reviews, dependent: :destroy
	has_many :passive_rates, class_name: Rate.name, foreign_key: book_id, dependent: :destroy
	has_many :raters, through: :passive_rates, source: :user

	mount_uploader :image, PictureUploader
	# Format date
	VALID_DATE_REGEX = /\A\d{4}\-(?:0?[1-9]|1[0-2])\-(?:0?[1-9]|[1-2]\d|3[01])\z/i
	# validate some field
	validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
	validates :description, presence: true, length: { maximum: 1000 }
	validates	:image, presence: true
	validates :author, presence: true, length: { maximum: 50 }
	validates :publish_date, presence: true, format: { with: VALID_DATE_REGEX }

	# scope of BOOK
	scope :search, ->search do
		where("name LIKE ?", "%#{search}%").limit(5)
	end
	scope :more_rate, -> do
		order(rating: :desc).limit(5)
	end
	scope :newest, ->{order created_at: :desc}
	scope :search_follow_name_or_author, ->search do
		where("name LIKE ? OR author LIKE ?", "%#{search}%", "%#{search}%")
	end
	scope :search_by_category, -> do
		
	end
end

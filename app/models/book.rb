class Book < ApplicationRecord
  belongs_to :category

  mount_uploader :image, PictureUploader
  
  has_many :reviews, dependent: :destroy
  has_many :passive_rates, class_name: Rating.name,
    foreign_key: :book_id, dependent: :destroy
  has_many :raters, through: :passive_rates, source: :user
  has_many :rates, class_name: Rating.name

  VALID_DATE_REGEX = /\A\d{4}\-(?:0?[1-9]|1[0-2])\-(?:0?[1-9]|[1-2]\d|3[01])\z/i
  validates :title, presence: true, length: {maximum: 100}, uniqueness: true
  validates :description, presence: true
  validates :publish_date, presence: true, format: { with: VALID_DATE_REGEX}
  validates :author, presence: true
  validate  :image_size

  scope :more_rate, -> do
    order(rating: :desc).limit Settings.limit_book
  end
  scope :get_books_except_current_book, ->id do
    where("id != ?", id).limit Settings.limit_book
  end
  scope :show_newest, -> do
    order(created_at: :desc).limit Settings.limit_book
  end
  scope :filter_newest, ->{order created_at: :desc}
  scope :search_by_title, ->search do
    where "title LIKE ?", "%#{search}%"
  end
  scope :filter_title_book_or_author, ->search do
    where "title LIKE ? OR author LIKE ?", "%#{search}%", "%#{search}%"
  end
  scope :search_by_category, ->category_id do
      where category_id: category_id
  end
  scope :search_name_or_author, ->search do
    filter_title_book_or_author search
  end
  scope :favourite_books, ->id do
    Book.joins("INNER JOIN bookmarks ON books.id = bookmarks.book_id")
      .where("bookmarks.user_id = ?", id).limit Settings.limit_book
  end

  private
  def image_size
    if image.size > Settings.size_image.megabytes
      errors.add :image, Settings.alert_size_image
    end
  end
end

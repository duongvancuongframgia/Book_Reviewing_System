class User < ApplicationRecord
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships,
    source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_likes, class_name: Like.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :liking, through: :active_likes, source: :activity
  has_many :active_rates, class_name: Rating.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :rating, through: :active_rates, source: :book
  has_many :reviews, dependent: :destroy
  has_many :active_bookmarks, class_name: Bookmark.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :favouriting, through: :active_bookmarks, source: :book
  has_many :requests
  has_many :comments
  has_many :activities

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  mount_uploader :avatar, PictureUploader
  has_secure_password

  validates :name, presence: true, length: { maximum: Settings.max_len }
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.min_len_pass}, allow_blank: true
  validate  :picture_size

  scope :all_except, ->(user) { where.not(id: user) }

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  scope :favourite_books, ->user_id do
    Book.joins("INNER JOIN bookmarks ON books.id = bookmarks.book_id")
      .where("bookmarks.user_id = ? AND bookmarks.favorite = ?",
      user_id, true).limit Settings.limit_book
  end

  scope :filter_read_books, ->user_id do
    Book.joins("INNER JOIN bookmarks ON books.id = bookmarks.book_id")
      .where("bookmarks.user_id = ? AND bookmarks.status_bookmarks = ?",
      user_id, true).limit Settings.limit_book
  end

  scope :filter_like_activity, ->activity_id do
    Like.where "activity_id = ?", activity_id
  end

  def like activity
    active_likes.create activity_id: activity.id
  end

  def unlike activity
    active_likes.find_by(activity_id: activity.id).destroy
  end

  def liking? activity, action_type
    @active = Activity.find_by user_id: id,
      object_id: activity.id, action_type: action_type
    liking.include? @active
  end

  def favourite book
    active_bookmarks.create book_id: book.id
  end

  def unfavourite book
    active_bookmarks.find_by(book_id: book.id).destroy
  end

  def favouriting? book
    favouriting.include? book
  end

  def rating? book
    rating.include? book
  end

  def rate book, num_rate
    active_rates.create book_id: book.id, num_rate: num_rate
    book.update_attributes rating: book.raters.average(:num_rate)
  end

  def re_rate book, num_rate
    active_rates.find_by(book_id: book.id).update_attributes num_rate: num_rate
    book.update_attributes rating: book.raters.average(:num_rate)
  end

  def get_like object, action_type
    @actity = Activity.find_by object_id: object.id, action_type: action_type
    return Like.find_by activity_id: @actity.id
  end

  def get_rating user, book
    Rating.find_by user_id: user.id, book_id: book.id
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def picture_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end

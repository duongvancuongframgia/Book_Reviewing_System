class Activity < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :object_id, presence: true, uniqueness: true
  validates :user_id, presence: true, uniqueness: true
end

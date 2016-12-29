class Like < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :user, presence: true
  validates :activity, presence: true
  validates :user_id, uniqueness: {scope: :activity_id}
end

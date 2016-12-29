class Activity < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  enum action_type: [:review, :comment]

  validates :object_id, presence: true
  validates :object_id, uniqueness: { scope: :action_type }
end

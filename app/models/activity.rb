class Activity < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :object_id, presence: true
  validates :object_id, uniqueness: {scope: :action_type}

  enum action_type: [ :review, :comment ]
end

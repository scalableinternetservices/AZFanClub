class Comment < ApplicationRecord
  belongs_to :user
  has_one :poll, through: :user
  validates :body, presence: true
  paginates_per 5
end

class Comment < ApplicationRecord
  belongs_to :user
  has_one :poll, through: :user
end

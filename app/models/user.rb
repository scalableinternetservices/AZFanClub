class User < ApplicationRecord
  belongs_to :poll
  has_many :time_frames
  has_many :comments
  validates :name, presence: true

  # accepts_nested_attributes_for :time_frames, :allow_destroy => :true
end

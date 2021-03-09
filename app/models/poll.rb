class Poll < ApplicationRecord
  has_many :users
  has_many :comments, through: :users
  # has_many :time_frames, through: :users
  validates :title, presence: true
  validates :timeframe_start, presence: true
  validates :timeframe_end, presence: true
  validates :daily_start, numericality: { only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 24 }
  validates :daily_end, numericality: { only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 24 }
  validate :validateTimeframe
  paginates_per 5

  def validateTimeframe
    if timeframe_start.nil? || timeframe_end.nil? || (timeframe_start > timeframe_end)
      errors.add(:timeframe_start, "must be before end time")
    end
    if daily_start > daily_end
      errors.add(:daily_start, "must be before daily end time")
    end
  end
end

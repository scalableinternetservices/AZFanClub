class Poll < ApplicationRecord
  has_many :users
  # has_many :time_frames, through: :users
  validates :title, presence: true
  validates :timeframe_start, presence: true
  validates :timeframe_end, presence: true
  validate :validateTimeframe

  def validateTimeframe
    if timeframe_start.nil? || timeframe_end.nil? || (timeframe_start > timeframe_end)
      errors.add(:timeframe_start, "must be before end time")
    end
  end
end

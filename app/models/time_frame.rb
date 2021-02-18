class TimeFrame < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validateTimeframe

  def validateTimeframe
    if start_time.nil? || end_time.nil? || (start_time > end_time)
      errors.add(:start_time, "must be before end time")
    end
  end

end

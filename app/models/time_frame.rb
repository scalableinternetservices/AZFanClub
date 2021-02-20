class TimeFrame < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validateTimeframe

  def validateTimeframe
    if start_time.nil? || end_time.nil? || (start_time > end_time)
      errors.add(:start_time, "must be before end time")
    end
    poll = Poll.find(user.poll_id)
    if !(poll.timeframe_start <= start_time && start_time <= poll.timeframe_end)
      errors.add(:start_time, "must be inside poll time")
    end
    if !(poll.timeframe_start <= end_time && end_time <= poll.timeframe_end)
      errors.add(:end_time, "must be inside poll time")
    end
    #logger.debug "PRINTING POLL" + @poll
    #logger.debug "Poll object" + .to_s
  end

end

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
  TimeSlotInfo = Struct.new(:count, :penalty)

  def validateTimeframe
    if timeframe_start.nil? || timeframe_end.nil? || (timeframe_start > timeframe_end)
      errors.add(:timeframe_start, "must be before end time")
    end
    if daily_start > daily_end
      errors.add(:daily_start, "must be before daily end time")
    end
  end

  def optimal_times
    # logger.debug Rails.cache.instance_variable_get(:@data).to_s
    Rails.cache.fetch("#{cache_key_with_version}/optimal_times", expires_in: 12.hours) do
      # logger.debug "NOT CACHED"
      increment = 15*60

      time_slot_user_counts = {}

      users.each do |user|
        user.time_frames.each do |time_frame|
          start_time = time_frame.start_time
          # logger.debug "START BEFORE ROUND " + start_time.to_s
          start_time = Time.at((start_time.to_r / increment).ceil * increment)
          # logger.debug "START AFTER ROUND " + start_time.to_s
          end_time = time_frame.end_time
          # logger.debug "END BEFORE ROUND " + end_time.to_s
          end_time = Time.at((end_time.to_r / increment).floor * increment)
          # logger.debug "END AFTER ROUND " + end_time.to_s

          cur_time = start_time

          while cur_time < end_time do 
            if time_slot_user_counts[cur_time].nil?
              time_slot_user_counts[cur_time] = TimeSlotInfo.new(1, time_frame.tier ** 2)
            else
              time_slot_user_counts[cur_time].count += 1
              time_slot_user_counts[cur_time].penalty += time_frame.tier ** 2
            end
            cur_time += increment
          end
        end
        
        # logger.debug "PRINTING USER " + user.name
      end
      # logger.debug "USER COUNTS " + time_slot_user_counts.to_s

      max_count = 0
      optimal_times = {}

      time_slot_user_counts.each do |time_slot, info|
        if info.count > max_count
          optimal_times.clear()
          max_count = info.count
          optimal_times[time_slot] = info.penalty
        elsif info.count == max_count
          optimal_times[time_slot] = info.penalty
        end
      end

      optimal_times = optimal_times.sort_by{|k,v| v}
      # logger.debug "OPTIMAL TIMES " + optimal_times.to_s
      result = []
      optimal_times.each do |time_slot, penalty|
        result.append(time_slot.strftime("%F %H:%M:%S %Z"))       
      end
      result
    end
  end
end

class Poll < ApplicationRecord
  validates :title, presence: true
  validates :timeframe_start, presence: true
  validates :timeframe_end, presence: true
end

class AddDailyStartStopToPoll < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :daily_start, :integer
    add_column :polls, :daily_end, :integer
  end
end

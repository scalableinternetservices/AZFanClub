class AddStartStopToPoll < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :timeframe_start, :datetime
    add_column :polls, :timeframe_end, :datetime
  end
end

class AddTierToTimeFrame < ActiveRecord::Migration[6.1]
  def change
    add_column :time_frames, :tier, :integer
  end
end

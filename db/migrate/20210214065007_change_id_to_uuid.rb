class ChangeIdToUuid < ActiveRecord::Migration[6.1]
  def change
    change_column :polls, :id, :uuid
  end
end

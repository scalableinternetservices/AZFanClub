class ChangeIdToUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :user_uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }
    remove_column :polls, :id
    rename_column :polls, :user_uuid, :id
    execute "ALTER TABLE polls ADD PRIMARY KEY (id);"

  end
end

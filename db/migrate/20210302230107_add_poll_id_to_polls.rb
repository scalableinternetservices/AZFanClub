class AddPollIdToPolls < ActiveRecord::Migration[6.1]
  def change
    execute "ALTER TABLE POLLS ADD COLUMN poll_id SERIAL;"
    add_index(:polls, :poll_id, unique: true)
  end
end

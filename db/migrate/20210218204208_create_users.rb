class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.references :poll, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

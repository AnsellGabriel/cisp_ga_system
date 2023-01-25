class CreateElections < ActiveRecord::Migration[7.0]
  def change
    create_table :elections do |t|
      t.references :event_hub#, null: false, foreign_key: true
      t.references :coop_event
      t.string :voter_code

      t.timestamps
    end
  end
end

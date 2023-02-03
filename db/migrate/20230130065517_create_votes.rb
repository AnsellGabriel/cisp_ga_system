class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :event_hub, null: false, foreign_key: true
      t.references :coop_event, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.references :elect_position
      t.integer :vote_amount
      t.integer :vote_entry
      t.boolean :post

      t.timestamps
    end
  end
end

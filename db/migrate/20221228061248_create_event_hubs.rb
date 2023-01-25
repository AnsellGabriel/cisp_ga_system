class CreateEventHubs < ActiveRecord::Migration[7.0]
  def change
    create_table :event_hubs do |t|
      t.references :coop_event, null: false, foreign_key: true
      t.references :cooperative, null: false, foreign_key: true
      t.decimal :capital, precision: 18, scale: 2
      t.decimal :vote_power, precision: 18, scale: 2
      t.string :vote_code
      t.boolean :voted
      t.timestamps
    end
  end
end

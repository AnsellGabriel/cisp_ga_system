class CreateCoopEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :coop_events do |t|
      t.string :name
      t.date :event_date
      t.text :description
      t.boolean :election
      t.boolean :active

      t.timestamps
    end
  end
end

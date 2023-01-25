class CreateElectPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :elect_positions do |t|
      t.references :coop_event, null: false, foreign_key: true
      t.string :name
      t.integer :vacant

      t.timestamps
    end
  end
end

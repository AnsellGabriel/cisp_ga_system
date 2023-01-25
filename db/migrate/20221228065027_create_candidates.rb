class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.references :event_hub, null: false, foreign_key: true
      t.references :elect_position, null: false, foreign_key: true
      t.references :coop_event
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :suffix
      t.date :birth_date
      t.text :address
      t.string :mobile_number
      t.string :email
      t.string :education
      t.string :company
      t.string :occupation
      t.string :status

      t.timestamps
    end
  end
end

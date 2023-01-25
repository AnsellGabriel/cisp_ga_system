class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.references :event_hub#, null: false, foreign_key: true
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.date :birth_date
      t.string :mobile_number
      t.string :email
      t.string :guest_type
      t.string :attendance
      t.boolean :attend
      t.timestamps
    end
  end
end

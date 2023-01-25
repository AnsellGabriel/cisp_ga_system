class CreateCooperatives < ActiveRecord::Migration[7.0]
  def change
    create_table :cooperatives do |t|
      t.string :name
      t.references :geo_region#, null: false, foreign_key: true
      t.references :geo_province#, null: false, foreign_key: true
      t.references :geo_municipality#, null: false, foreign_key: true
      t.references :geo_barangay#, null: false, foreign_key: true
      t.string :street
      t.string :tin
      t.string :registration_no
      t.string :coop_type
      t.string :email
      t.string :contact_no

      t.timestamps
    end
  end
end

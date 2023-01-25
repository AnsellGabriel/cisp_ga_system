class CreateGeoProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :geo_provinces do |t|
      t.references :geo_region, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end

class CreateReferendums < ActiveRecord::Migration[7.0]
  def change
    create_table :referendums do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end

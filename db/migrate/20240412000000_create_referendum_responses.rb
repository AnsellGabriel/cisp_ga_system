class CreateReferendumResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :referendum_responses do |t|
      t.references :event_hub#, null: false, foreign_key: true
      t.references :referendum#, null: false, foreign_key: true
      t.boolean :response
      t.integer :vote_amount
      t.timestamps
    end
  end
end

class AddDietarytoRegistration < ActiveRecord::Migration[7.0]
  def change
    add_column :registrations, :dietary, :string
  end
end

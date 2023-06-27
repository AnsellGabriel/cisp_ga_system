class AddGenderToRegistration < ActiveRecord::Migration[7.0]
  def change
    add_column :registrations, :gender, :string
  end
end

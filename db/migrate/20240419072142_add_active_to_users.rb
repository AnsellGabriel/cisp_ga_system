class AddActiveToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :active, :boolean
    add_column :users, :admin, :boolean
    # add_column :registrations, :attend_date, :datetime
  end
end

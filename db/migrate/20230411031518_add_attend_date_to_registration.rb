class AddAttendDateToRegistration < ActiveRecord::Migration[7.0]
  def change
    add_column :registrations, :attend_date, :datetime
  end
end

class AddTentativeToRegistration < ActiveRecord::Migration[7.0]
  def change
    add_column :registrations, :tentative, :boolean
  end
end

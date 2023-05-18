class AddPriceToRegistration < ActiveRecord::Migration[7.0]
  def change
    add_column :registrations, :price, :decimal, precision: 8, scale: 2
    add_column :registrations, :paid, :boolean
    add_column :registrations, :award, :boolean

  end
end

class AddCodeToEventHub < ActiveRecord::Migration[7.0]
  def change
    add_column :event_hubs, :code, :string
  end
end

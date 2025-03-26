class AddVoteDateToEventHub < ActiveRecord::Migration[7.0]
  def change
    add_column :event_hubs, :vote_date, :datetime
  end
end

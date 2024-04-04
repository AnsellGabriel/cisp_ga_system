class AddVoteDateToEventhub < ActiveRecord::Migration[7.0]
  def change
    add_column :event_hubs, :vote_date, :datetime
    add_column :event_hubs, :attend, :boolean
  end
end

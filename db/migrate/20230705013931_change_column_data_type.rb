class ChangeColumnDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :votes, :vote_amount, :decimal, precision: 10, scale: 2
  end
end

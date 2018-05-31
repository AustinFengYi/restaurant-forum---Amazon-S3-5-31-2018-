class Repair < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :favorites_count, :integer, default: 0
    remove_column :favorites,:favorites_count
  end
end

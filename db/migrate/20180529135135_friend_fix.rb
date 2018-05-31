class FriendFix < ActiveRecord::Migration[5.1]
  def change
    remove_column :friendships,:status
  end
end

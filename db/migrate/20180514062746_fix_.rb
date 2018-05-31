class Fix < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments , :category_id, :restaurant_id
  end
end

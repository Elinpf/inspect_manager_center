class AddRecentlyToStoreFile < ActiveRecord::Migration[5.1]
  def change
    add_column :store_files, :recently, :boolean, default: true
  end
end

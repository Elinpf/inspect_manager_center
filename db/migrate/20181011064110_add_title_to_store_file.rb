class AddTitleToStoreFile < ActiveRecord::Migration[5.1]
  def change
    add_column :store_files, :title, :string
  end
end

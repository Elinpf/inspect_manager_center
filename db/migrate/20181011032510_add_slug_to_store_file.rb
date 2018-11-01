class AddSlugToStoreFile < ActiveRecord::Migration[5.1]
  def change
    add_column :store_files, :slug, :string
    add_index  :store_files, :slug, unique: true
  end
end

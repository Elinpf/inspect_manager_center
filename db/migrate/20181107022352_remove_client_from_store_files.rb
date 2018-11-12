class RemoveClientFromStoreFiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :store_files, :client, :string
    remove_column :store_files, :locate, :string
    add_reference :store_files, :client, foreign_key: true
  end
end

class AddClientToStoreFile < ActiveRecord::Migration[5.1]
  def change
    add_column :store_files, :client, :string
  end
end

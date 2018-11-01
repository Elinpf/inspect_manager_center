class AddDevicesNumberToStoreFile < ActiveRecord::Migration[5.1]
  def change
    add_column :store_files, :devices_number, :integer
  end
end

class AddParserPathToStoreFile < ActiveRecord::Migration[5.1]
  def change
    add_column :store_files, :parser_path, :string
  end
end

class CreateStoreFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :store_files do |t|
      t.string :locate
      t.date :inspect_time
      t.string :path
      t.integer :version
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

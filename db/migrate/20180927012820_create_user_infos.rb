class CreateUserInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :user_infos do |t|
      t.string :name
      t.string :position
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

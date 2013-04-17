class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :user_id
      t.string :name
      t.string :path
      t.string :description
      t.boolean :active
      t.datetime :deadline

      t.timestamps
    end
  end
end

class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :name
      t.integer :version
      t.integer :homework_user_id
      t.string :ip

      t.timestamps
    end
  end
end

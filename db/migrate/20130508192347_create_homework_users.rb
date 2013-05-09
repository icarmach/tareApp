class CreateHomeworkUsers < ActiveRecord::Migration
  def change
    create_table :homework_users do |t|
      t.integer :homework_id
      t.integer :user_id

      t.timestamps
    end
  end
end

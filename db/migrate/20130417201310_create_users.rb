class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :lastname
      t.integer :deleted
      t.boolean :admin
      t.string :hash
      t.string :salt

      t.timestamps
    end
  end
end

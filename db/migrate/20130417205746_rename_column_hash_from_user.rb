class RenameColumnHashFromUser < ActiveRecord::Migration
  def up
  	rename_column :users, :hash, :hash_password
  end

  def down
  	rename_column :users, :hash_password, :hash
  end
end

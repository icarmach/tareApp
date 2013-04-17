class AddColumnToArchive < ActiveRecord::Migration
  def change
    add_column :archives, :path, :string
  end
end

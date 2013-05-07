class AddAttachmentDescriptionFileToHomeworks < ActiveRecord::Migration
  def self.up
    change_table :homeworks do |t|
      t.attachment :description_file
    end
  end

  def self.down
    drop_attached_file :homeworks, :description_file
  end
end

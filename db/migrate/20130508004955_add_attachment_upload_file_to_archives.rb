class AddAttachmentUploadFileToArchives < ActiveRecord::Migration
  def self.up
    change_table :archives do |t|
      t.attachment :upload_file
    end
  end

  def self.down
    drop_attached_file :archives, :upload_file
  end
end

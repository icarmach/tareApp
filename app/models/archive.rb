class Archive < ActiveRecord::Base
  attr_accessible :homework_user_id, :ip, :name, :version, :upload_file
  has_attached_file :upload_file, :default_url => ""

  belongs_to :homework_user
  
  validates_attachment_size :upload_file, :in => 0.megabytes..50.megabytes, :message => "El archivo que intenta subir no puede exceder los 50 MB"
end

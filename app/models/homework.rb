class Homework < ActiveRecord::Base
  attr_accessible :active, :deadline, :description, :name, :path, :user_id, :description_file
  has_attached_file :description_file

  has_many :homework_users
  belongs_to :user
  
  validates_attachment_size :description_file, :in => 0.megabytes..50.megabytes, :message => "El archivo que intenta subir no puede exceder los 50 MB"

end

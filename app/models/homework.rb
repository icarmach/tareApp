class Homework < ActiveRecord::Base
  attr_accessible :active, :deadline, :description, :name, :path, :user_id, :description_file
  has_attached_file :description_file
end

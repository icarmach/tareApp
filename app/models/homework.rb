class Homework < ActiveRecord::Base
  attr_accessible :active, :deadline, :description, :name, :path, :user_id
end

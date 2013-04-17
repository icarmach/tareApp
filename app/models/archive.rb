class Archive < ActiveRecord::Base
  attr_accessible :homework_user_id, :ip, :name, :version
end

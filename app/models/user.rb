class User < ActiveRecord::Base
  attr_accessible :admin, :deleted, :email, :hash_password, :lastname, :name, :salt
end

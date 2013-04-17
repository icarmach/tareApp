class User < ActiveRecord::Base
  attr_accessible :admin, :deleted, :email, :hash, :lastname, :name, :salt
end

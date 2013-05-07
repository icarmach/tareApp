class User < ActiveRecord::Base
  attr_accessible :admin, :deleted, :email, :hash_password, :lastname, :name, :salt
  
  	validates :email,
		:uniqueness => true,
		:format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  
end

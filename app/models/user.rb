class User < ActiveRecord::Base
  attr_accessible :admin, :deleted, :email, :hash_password, :lastname, :name, :salt
  
  has_many :homeworks
  has_many :homework_users

  	validates :email,
		:uniqueness => true,
		:format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  
	def other_homeworks()
		homeworks = Array.new
		self.homework_users.each do |hu|
			homeworks.push(hu.homework_id)
		end
		homeworks.uniq!
		return homeworks
	end
  
end

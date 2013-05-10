class UserMailer < ActionMailer::Base
	default from: "no-reply@tareApp.com"
	
	def welcome_email(user)
		@user = user
		mail(:to => user.email, :subject => "Bienvenido a TareApp")
	end
	
	def invitation_email(homework, user)
		@homework = homework
		@user = user
		@owner = homework.user
		mail(:to => user.email, :subject => "Has sido invitado a participar en #{homework.name}")
	end
	
	def first_invitation_email(homework, user)
		@homework = homework
		@user = user
		@owner = homework.user
		mail(:to => user.email, :subject => "Has sido invitado a participar en #{homework.name}")
	end
end

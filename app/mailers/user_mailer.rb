class UserMailer < ActionMailer::Base
  default from: 'noreturn@example.com'

  def follow_up_email(email)
    mail to: email,
         subject: 'We hope you are enjoying our app'
  end
end

class UserMailer < ApplicationMailer
  default from: 'eugenebookstore@gmail.com'

  def confirm_account(user)
    @user = user
    @url  = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

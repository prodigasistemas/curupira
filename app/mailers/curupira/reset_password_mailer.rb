class Curupira::ResetPasswordMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Recuperar senha')
  end

  def reseted(user)
    @user = user
    mail(to: @user.email, subject: 'Você criou uma nova senha')
  end
end

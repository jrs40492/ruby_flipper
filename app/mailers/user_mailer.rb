class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user

    mail to: user.email, subject: "Account Activation"
  end

  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Flipper Password Reset"
  end
end

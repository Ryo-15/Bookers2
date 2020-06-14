class ThanksMailer < ApplicationMailer
  # 送信元アドレス（ENVで非公開にする）
  default :from => ENV['USER_NAME']

  # 受信先アドレス
  def signup_thanks_mail(user)
    @user = user
    @greeting = "Hi"
    mail( :to => @user.email, :subject => "会員登録が完了しました。" )
  end
end

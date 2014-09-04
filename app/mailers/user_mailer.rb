# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "kanbing365@163.com"

  def find_pwd(user, url)
    @user = user
    @url = url
    mail(:to => user.email, :subject => "忘记密码")
  end

  # 账号激活
  def account_active(email,url)
    @url = url
    mail(:to => email, :subject => "账号激活-绿色医疗网站")
  end
end

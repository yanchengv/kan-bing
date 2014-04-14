# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "yxf_cat_0403@126.com"

  def find_pwd(user, url)
    @user = user
    @url = url
    mail(:to => user.email, :subject => "忘记密码")
  end
end

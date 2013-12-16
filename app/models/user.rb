#encoding: utf-8
class User < ActiveRecord::Base
  require 'multi_json'
  require 'uri'
  require 'net/http'

  attr_accessible :username,
                  :password,
                  :password_confirmation,
                  :doctor_id,
                  :patient_id,
                  :card_number,
                  :email,
                  :is_doctor,
                  :is_health_admin

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def curl(path,*arg)
    uri = URI('http://demo.kanbing365.com:9000/'+path)
    res = Net::HTTP.post_form(uri, *arg)
    @search_result = JSON.parse res.body
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end

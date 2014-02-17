#encoding: utf-8
class User< ActiveRecord::Base
  before_create :create_remember_token
  belongs_to :doctor, :foreign_key => :doctor_id
  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible :id, :name, :password, :password_confirmation, :patient_id, :doctor_id, :nurse_id, :is_enabled,
                  :remember_token  ,:created_by   ,:manager_id  ,:level,:technician_id,:password_digest
  attr_reader :password
  has_secure_password :validations => false

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  require 'multi_json'
  include HTTParty
  CIS_HOST=Settings.cis
  CIS_URL='http://'+CIS_HOST.name+':'+CIS_HOST.port.to_s+'/'

#调用post请求接口
  def post_req(path,params)
    params= {:body=>params}
    @search_result=HTTParty.post(CIS_URL+path,params)
  end

#根据令牌调用接口查找当前用户
  def find_by_remember_token(remember_token)
    path='sessions/find_user?remember_token='+remember_token.to_s
    @search_result = self.get_req(path)
    if @search_result['success']
      return @search_result['data']
    else
      return nil
    end
  end

#调用get请求接口
  def get_req(path)
    @search_result=HTTParty.get(CIS_URL+path)
  end

#调用put请求接口
  def put_req(path,data)
    uri = CIS_URL+path
    c = Curl::Easy.new(uri)
    c.http_put(data)
    @search_result = c.body_str
  end

#调用delete请求接口
  def del_req(path)
    puts 'del_req'
    @search_result=HTTParty.delete(CIS_URL+path)
  end
  private
  def create_remember_token
    #Create the token
    self.remember_token=User.encrypt(User.new_remember_token)
  end
end
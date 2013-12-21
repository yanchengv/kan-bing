#encoding: utf-8
class User
  require 'multi_json'
  require 'uri'
  require 'net/http'

  CIS_HOST=Settings.cis
  CIS_URL='http://'+CIS_HOST.name+':'+CIS_HOST.port.to_s+'/'
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

#调用post请求接口
  def post_req(path,*arg)
    uri = URI(CIS_URL+path)
    res = Net::HTTP.post_form(uri, *arg)
    puts res.body
    @search_result = JSON.parse res.body
  end

#根据令牌调用接口查找当前用户
  def find_by_remember_token(remember_token)
    path='sessions/find_user?remember_token='+remember_token.to_s
    @search_result = self.get_req(path)
    if @search_result['success']
      puts  @search_result['data']
      return @search_result['data']
    else
      return nil
    end
  end

#调用get请求接口
  def get_req(path)
    uri = URI(CIS_URL+path)
    res = Net::HTTP.get(uri)
    @search_result = JSON.parse res
  end

#调用put请求接口
  def put_req(path,data)
    uri = CIS_URL+path
    c = Curl::Easy.new(uri)
    c.http_put(data)
    @search_result = c.body_str
  end

  private

  #def create_remember_token
  #  self.remember_token = User.encrypt(User.new_remember_token)
  #end
end

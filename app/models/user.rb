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
  def post_req(path,*arg)
    uri = URI(CIS_URL+path)
    res = Net::HTTP.post_form(uri, *arg)
    puts res.body
    @search_result = JSON.parse res.body
  end
  def find_by_remember_token(remember_token)
    path='sessions/find_user'
    param = {'remember_token' => remember_token}
    @search_result = self.post_req(path,param)
    if @search_result['success']
      puts  @search_result['data']
      return @search_result['data']
    else
      return nil
    end
  end
  def get_req(path)
    uri = URI(CIS_URL+path)
    res = Net::HTTP.get(uri)
    @search_result = JSON.parse res
  end

  private

  #def create_remember_token
  #  self.remember_token = User.encrypt(User.new_remember_token)
  #end
end

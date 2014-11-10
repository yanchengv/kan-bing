#encoding:utf-8
require 'json'
class WeixinUser < ActiveRecord::Base
  attr_accessible :id, :openid, :patient_id, :doctor_id, :created_at, :updated_at
  #根据患者id发送客服消息
  def send_message_to_weixin(type,id,message='您好')
    #@wxus = (type=='patient') ? WeixinUser.where('patient_id=?',id) : WeixinUser.where('doctor_id=?',id)
    @wxus = WeixinUser.where('patient_id=?',id)
    res = 'false'
    if @wxus.size != 0
      openid = @wxus.first.openid
      res = sendByOpenId(openid,message)
    end
    res
  end
  #根据open_id发送客服消息
  def sendByOpenId(openid,message='您好')
    access_token = getAccessToken
    sendText(access_token,openid,message)
  end
  #根据open_id发送模板消息
  def sendTmpMesByOpenId(open_id)
    access_token = getAccessToken
    body =  {
        "touser"=>open_id,
        "template_id"=>"L9JQbPqr_d218GIyn0SU4sROUP4QvwuuCeUADcwQIEo",
        "url"=>"http://www.kanbing365.com",
        "topcolor"=>"#FF0000",
        "data"=>{
            "first"=> {
                "value"=>"您好，您已成功消费。",
                "color"=>"#0A0A0A"
            },
            "keynote1"=>{
                "value"=>"巧克力",
                "color"=>"#CCCCCC"
            },
            "keynote2"=> {
                "value"=>"39.8元",
                "color"=>"#CCCCCC"
            },
            "keynote3"=>{
                "value"=>"巧克力",
                "color"=>"#CCCCCC"
            },
            "keynote4"=> {
                "value"=>"39.8元",
                "color"=>"#CCCCCC"
            },
            "remark"=> {
                "value"=>"欢迎再次购买。",
                "color"=>"#173177"
            }
        }
    }
    sendTmpText(access_token,body)
  end

  #获取access_token
  def getAccessToken
    url = Settings.weixin.access_token + 'appid=' + Settings.weixin.app_id + '&secret=' + Settings.weixin.app_secret
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = JSON.parse response.body
    @data["access_token"]
  end
  #微信API post请求
  def sendByNetHttp(url, send_body)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.request_uri)
    body = send_body
    req.body = body.to_json
    response = http.request(req)
    res = (JSON.parse response.body)["errmsg"]
  end
  #发送消息
  def sendText(access_token,openid,message)
    body = {
        touser: openid,
        msgtype: "text",
        text: {
            content: message
        }
    }
    sendByNetHttp(Settings.weixin.send_message + access_token,body)
  end
  #发送模板消息
  def sendTmpText(access_token,body)
    sendByNetHttp("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + access_token, body)
  end
end

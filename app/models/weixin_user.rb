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
    body = {
        touser: openid,
        msgtype: "text",
        text: {
            content: message

        }
    }
    sendText(access_token,body)
  end
  #根据open_id发送模板消息
  def sendTmpMesByOpenId(open_id)
    access_token = getAccessToken
    body =  {
        "touser"=>open_id,
        "template_id"=>"VcMs25u7E3zy3fg7xMcIaNEJToyvZLEjPhru3tze2b0",
        "url"=>"http://www.kanbing365.com",
        "topcolor"=>"#000000",
        "data"=>{
            "first"=> {
                "value"=>"你好，您有新的健康档案已生成，详情如下",
                "color"=>"#000000"
            },
            "keyword1"=>{
                "value"=>"超声",
                "color"=>"#0243ba"
            },
            "keyword2"=> {
                "value"=>"清华大学玉泉医院",
                "color"=>"#0243ba"
            },
            "keyword3"=>{
                "value"=>"2014-11-10",
                "color"=>"#0243ba"
            },
            "remark"=> {
                "value"=>"点击可查看健康档案详情！",
                "color"=>"#000000"
            }
        }
    }
    sendTmpText(access_token,body)
  end

  # 医院同步健康档案时，为患者推送通知查看的消息   type的类型"检验报告：report,超声：ultrasound,CT：ct 核磁：heci" url=ct或者超声的地址
    def  send_health_tempate_message(patient_id,report_id,type,key)
      # aes加密和揭秘
      require "aes"
      patient_id=patient_id.gsub(" ","+")
      report_id=report_id.gsub(" ","+")
      patient_id=AES.decrypt(patient_id.to_s,key)  #aes解密
      report_id=AES.decrypt(report_id.to_s,key)    #aes解密
      @weixin_user=WeixinUser.where(patient_id:patient_id).first
      case type
        when "ultrasound"
          type="超声报告"
          @report = InspectionUltrasound.where("id=?",report_id).first
          if  !@report.nil?
            # url=Settings.mimas+"/weixin_patient/ultrasound?child_id=#{@report.id}"
            url="http://www.ithwj.com/weixin_patient/ultrasound?child_id=#{@report.id}"
          end
        when "report"
          type="检验报告"
          @report = InspectionData.where("id=?",report_id).first
          if  !@report.nil?
            url=Settings.mimas+"/weixin_patient/reports?uuid=#{@report.thumbnail}&child_id=#{@report.id}"
          end
        when "ct"
          type="CT"
          @report = InspectionCt.where("id=?",report_id).first
          if  !@report.nil?
            url=Settings.mimas+"/weixin_patient/ct?uuid=#{@report.thumbnail}&child_id=#{@report.id}"
          end
        when "heci"
          type="核磁"
          @report = InspectionNuclearMagnetic.where("id=?",report_id).first
          if  !@report.nil?
            url=Settings.mimas+"/weixin_patient/ultrasound?uuid=#{@report.thumbnail}&child_id=#{@report.id}"
          end
        else

      end

      if !@weixin_user.nil? &&!@report.nil?
        open_id=@weixin_user.openid
        access_token = getAccessToken
      body =  {
          "touser"=>open_id,
          "template_id"=>"VcMs25u7E3zy3fg7xMcIaNEJToyvZLEjPhru3tze2b0",
          "url"=>url,
          "topcolor"=>"#000000",
          "data"=>{
              "first"=> {
                  "value"=>"你好，您有新的健康档案已同步到kanbing365公网，详情如下",
                  "color"=>"#000000"
              },
              "keyword1"=>{
                  "value"=>type,
                  "color"=>"#0243ba"
              },
              "keyword2"=> {
                  "value"=>@report.hospital,
                  "color"=>"#0243ba"
              },
              "keyword3"=>{
                  "value"=>@report.checked_at,
                  "color"=>"#0243ba"
              },
              "remark"=> {
                  "value"=>"点击可查看健康档案详情！",
                  "color"=>"#000000"
              }
          }
      }
      sendTmpText(access_token,body)
     end
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
  def sendText(access_token,body)
    sendByNetHttp(Settings.weixin.send_message + access_token,body)
  end

  #发送模板消息
  def sendTmpText(access_token,body)
    sendByNetHttp("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + access_token, body)
  end
end

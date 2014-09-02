class MobileApp::SmsCenterController < ApplicationController
  #require 'net/http'
  require 'iconv'
  require 'securerandom'
  skip_before_filter :verify_authenticity_token, :only => [:sent]
  def sent
    mobile_phone=params[:mobile_phone]
    verify_code=params[:verify_code]
    # @user=User.where(mobile_phone:mobile_phone).first
    # if @user.nil?
    #   render json:{flag:'用户不存在'}
    # else
      #@verify_code= SecureRandom.random_number(10**6)
      input_encode='gbk'
      out_encode='utf8'
      msg=Iconv.new('gb2312','utf8').iconv("恭喜您，注册的健康管理平台审核通过.您的激活验证码为："+verify_code+".请及时登陆:www.kanbing365.com网站激活，以防丢失.【绿色医疗】")
      url=URI.escape('http://www.smsadmin.cn/smsmarketing/wwwroot/api/get_send/?uid=viicare&pwd=viicare123&mobile='+mobile_phone+'&msg='+msg)
      @rs=Iconv.new(out_encode,input_encode).iconv(Net::HTTP.get(URI(url)))
      #Net::HTTP.get得到 返回值它的返回值有：
      #0：发送成功！
      #1：用户名或密码错误！
      #2：余额不足！
      #3：超过发送最大量1000条！
      #4：此用户不允许发送！
      #5：手机号或发送信息不能为空！
      #7：超过限制字数，请修改后发送！等等
      @a=@rs.split(//).first
      if @a.to_i==0
        render json:{flag:0}

        #返回一个登录验证码的界面
      elsif @a.to_i==2
        render json:{flag:2}
      elsif  @a.to_i==3
        render json:{flag:3}
      elsif    @a.to_i==4
        render json:{flag:4}
      elsif   @a.to_i==5
        render json:{flag:5}
      else
        render json:{flag:'位置错误'}
      end
    # end
    end

  # def sent
  #   p 111
  # end
  end

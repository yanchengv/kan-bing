class ApplicationController < ActionController::Base
  #before_filter :set_i18n_locale_from_params
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  #  ip

  ##promethues
  CISHOST=Settings.cis
  CISURL='http://'+CISHOST.name+':'+CISHOST.port.to_s+'/'



  FILESHOST=Settings.files
  FILESURL='http://'+ FILESHOST.name+':'+FILESHOST.port+'/files/'

  PICHOST=Settings.pic
  PICURL='http://'+PICHOST.name+':'+PICHOST.port+'/files/'

  #首页面图片
  PICHOST0=Settings.pic0
  PICURL0='http://'+PICHOST0.name+':'+PICHOST0.port+'/files/'
  #PACSHOST=Settings.pacs
  #PACSURL='http://'+PACSHOST.name+':'+PACSHOST.port.to_s+'/'

  #MIMHOST=Settings.mimas
  #MIMURL='http://'+MIMHOST.name+':'+MIMHOST.port.to_s+'/'


  #通过settings  获取server机器的ip  VIDEO_PLAYER_URL VIDEO_REST_URL 是相同的host port
  # FILESURL 通过 services/dfs  获取 dfs文件服务器内部地址
  phoebe_config = Settings.Phoebe
  phoebe_url ='http://'+phoebe_config.host+':'+phoebe_config.port.to_s+'/'
  VIDEO_IP = phoebe_config.host
  VIDEO_PLAYER_URL = phoebe_url
  VIDEO_REST_URL = phoebe_url

  protected
  def set_i18n_locale_from_params
    if signed_in?
      if current_user.language.nil? || current_user.language == ''
        I18n.locale = I18n.default_locale
      else
        I18n.locale = current_user.language
        session[:locale] = current_user.language
      end
    else
      if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
        session[:locale] = params[:locale]
      end
      I18n.locale = session[:locale] || I18n.default_locale
    end

  end
end

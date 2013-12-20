class ApplicationController < ActionController::Base
  #before_filter :set_i18n_locale_from_params
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  #  ip
  EMRHOST=Settings.emr
  EMRURL = 'http://'+EMRHOST.name+':'+EMRHOST.port.to_s+'/'
  ##promethues
  CISHOST=Settings.cis
  CISURL='http://'+CISHOST.name+':'+CISHOST.port.to_s+'/'

  HYPHOST=Settings.hyperion
  HYPURL='http://'+HYPHOST.name+':'+HYPHOST.port.to_s+'/'

  FILESHOST=Settings.files
  FILESURL='http://'+ FILESHOST.name+':'+FILESHOST.port+'/files/'

  PICHOST=Settings.pic
  PICURL='http://'+PICHOST.name+':'+PICHOST.port.to_s+'/'

  #PACSHOST=Settings.pacs
  #PACSURL='http://'+PACSHOST.name+':'+PACSHOST.port.to_s+'/'

  #MIMHOST=Settings.mimas
  #MIMURL='http://'+MIMHOST.name+':'+MIMHOST.port.to_s+'/'


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

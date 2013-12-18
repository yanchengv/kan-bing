class ApplicationController < ActionController::Base
  #before_filter :set_i18n_locale_from_params
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  #  ip
  EMR_HOST=Setting.EMRHost
  EMR_URL = 'http://'+EMR_HOST.name+':'+EMR_HOST.port.to_s+'/'
  ##promethues
  CIS_HOST=Setting.CISHost
  CIS_URL='http://'+CIS_HOST.name+':'+CIS_HOST.port.to_s+'/'

  HYP_HOST=Setting.HyperionHost
  HYP_URL='http://'+HYP_HOST.name+':'+HYP_HOST.port.to_s+'/'

  FIL_HOST=Setting.FilesHost
  FIL_URL='http://'+FIL_HOST.name+':'+FIL_HOST.port.to_s+'/'

  PIC_HOST=Setting.PICHost
  PIC_URL='http://'+PIC_HOST.name+':'+PIC_HOST.port.to_s+'/'

  #PACS_HOST=Setting.PACSHost
  #PACS_URL='http://'+PACS_HOST.name+':'+PACS_HOST.port.to_s+'/'

  #MIM_HOST=Setting.MimasHost
  #MIM_URL='http://'+MIM_HOST.name+':'+MIM_HOST.port.to_s+'/'


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

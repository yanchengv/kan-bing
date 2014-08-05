#encoding:utf-8
class VersionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show_version_app
    @version = Version.order('created_at').last
    render json:{success:true,data:@version}
  end

  def save_version_app
    version_num = params[:version_num]
    url = params[:url]
    update_time = params[:update_time]
    change_content = params[:change_content]
    if !version_num.nil? && version_num!=''
      @version = Version.new(version_num:version_num,url:url,update_time:update_time,change_content:change_content)
      if @version.save
        render json:{success:true,data:@version,msg:'保存成功！'}
      else
        render json:{success:false,msg:'保存失败！'}
      end
    else
      render json:{success:false,msg:'版本号(version_num)不可为空！'}
    end
  end
end

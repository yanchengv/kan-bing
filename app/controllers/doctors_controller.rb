class DoctorsController < ApplicationController


  #首页面医生显示
  def index_doctors_list
    @user = User.new
    @doctors_all = @user.get_req('doctors/find_all_doctor')['data']
    @num = @doctors_all.length
    @doctor = @doctors_all[0]
    @image_url = PICURL
    render partial: 'doctors/index_doctors_list'
  end
end

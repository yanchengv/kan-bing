#encoding:utf-8
class CaseController < ApplicationController
  layout 'mapp'
  def first_case
     #redirect_to 'http://192.168.1.103:3002/case/first_case'
  end

  def second_case
    #redirect_to 'http://192.168.1.103:3002/case/second_case'
  end

  def third_case
    #redirect_to 'http://192.168.1.103:3002/case/third_case'
  end

  def fourth_case
    #redirect_to 'http://192.168.1.103:3002/case/fourth_case'
  end

  def fifth_case
    #redirect_to 'http://192.168.1.103:3002/case/fifth_case'
  end

  def sixth_case
    #redirect_to 'http://192.168.1.103:3002/case/sixth_case'
  end

  def play_video
    @title=params[:title]
    @video_url=params[:video_url]
  end

end
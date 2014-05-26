#encoding:utf-8
class CaseController < ApplicationController
  layout 'mapp'
  def first_case
     #redirect_to 'http://192.168.1.102:3002/case/first_case'
  end

  def second_case

  end

  def third_case

  end

  def fourth_case

  end

  def fifth_case

  end

  def sixth_case

  end

  def play_video
    @title=params[:title]
    @video_url=params[:video_url]
  end

end
require 'open-uri'
class HealthRecordsController < ApplicationController
  def ct
    @studyUID = params[:studyUID]
  end
  def ultrasound
    @ip = VIDEO_IP
    @uuid = params[:uuid]
    @uuid = @uuid.split('.')[0]+'.png'
  end
  def get_video
    data = open(VIDEO_PLAYER_URL+'player.swf')
    send_data data.read, type: "application/x-shockwave-flash", disposition: "inline", stream: "true"
  end



  def blood_pressure
    render partial:'health_records/blood_pressure'
  end
  def ct2
    render partial:'ct'
  end
  def ultrasound2
    render partial:'health_records/ct'
  end
end

class HealthRecordsController < ApplicationController
  def ct

  end
  def ultrasound
    @uuid = params[:uuid]
    @uuid = @uuid.split('.')[0]+'.png'
  end
end

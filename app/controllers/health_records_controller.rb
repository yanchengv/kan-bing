class HealthRecordsController < ApplicationController
  def ct

  end
  def ultrasound
    @url = params[:url]
    @uuid = params[:uuid]

  end
end

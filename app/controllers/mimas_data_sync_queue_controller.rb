class MimasDataSyncQueueController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def create
    @data_sync=MimasDataSyncQueue.new
    response=@data_sync.add_data(params)
    puts response
    #render json:'{"data":{"data1":true}}'
    render json: response
  end
end

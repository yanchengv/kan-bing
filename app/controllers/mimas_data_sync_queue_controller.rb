class MimasDataSyncQueueController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
    @data_sync = MimasDataSyncQueue.all
    render :json => {success: true, data: @data_sync}
  end

  def create
    @data_sync=MimasDataSyncQueue.new
    response=@data_sync.add_data(params)
    render json: response
  end

  def destroy
    @data_sync=MimasDataSyncQueue.new
    response=@data_sync.destroy_data(params)
    render json: response
  end

  def change
    @data_sync=MimasDataSyncQueue.new
    response=@data_sync.update_data params
    render json: response
  end


  def destroy_by_id
    MimasDataSyncQueue.destroy(params[:mimas_syn_id])
    render :json => {success: true}
  end

  def find_by_id
    table_name=params[:table_name]
    id=params[:id]
    @datas=table_name.constantize.find_by_id(id)
    if @datas
      render :json => {success: true, data: @datas.as_json}
    else
      render json: {success: false, data: ''}
    end

  end

end

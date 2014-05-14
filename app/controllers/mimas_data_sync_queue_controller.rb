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
    if table_name == 'PacsFileRef'
      @obj = PacsFileRef.find_by_pk(id)
      if @obj
        @instance = PacsInstance.find(@obj.instance_fk)
        @filesystem = PacsFilesystem.find(@obj.filesystem_fk)
        @series = PacsSeriese.find(@instance.series_fk)
        @study = PacsStudy.find(@series.study_fk)
        @patient = PacsPatient.find(@study.patient_fk)
        render json: {success: true, data: @obj.as_json, instance: @instance.as_json, filesystem: @filesystem.as_json, series: @series.as_json, study: @study.as_json, patient: @patient.as_json}
      else
        render json: {success: false, data: ''}
      end
    else
      @datas = table_name.constantize.find_by_id(id)
      if @datas
        render :json => {success: true, data: @datas.as_json}
      else
        render json: {success: false, data: ''}
      end
    end
  end

end

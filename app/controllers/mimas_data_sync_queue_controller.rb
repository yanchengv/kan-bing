class MimasDataSyncQueueController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
    @data_sync = MimasDataSyncQueue.where(hospital:params[:hospital_id].to_s)
    render :json => {success: true, data: @data_sync}
  end

  def create
    @data_sync=MimasDataSyncQueue.new
    response=@data_sync.add_data(params)
    render json: response
  end

  def create_user
    @data_sync=MimasDataSyncQueue.new
    response=@data_sync.add_user(params)
    render json:response
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
        if table_name == 'Appointment'
          app_data = {id:@datas.id,patient_id:@datas.patient_id,doctor_id:@datas.doctor_id,appointment_day:@datas.appointment_day,start_time:@datas.start_time.to_time.strftime("%H:%M"),end_time:@datas.end_time.to_time.strftime("%H:%M"),status:@datas.status,hospital_id:@datas.hospital_id,department_id:@datas.department_id,appointment_schedule_id:@datas.appointment_schedule_id,dictionary_id:@datas.dictionary_id,appointment_arrange_id:@datas.appointment_arrange_id,doctor_name:@datas.doctor_name,patient_name:@datas.patient_name,hospital_name:@datas.hospital_name,department_name:@datas.department_name,dictionary_name:@datas.dictionary_name}
        elsif table_name == 'AppointmentSchedule'
          app_data = {id:@datas.id,doctor_id:@datas.doctor_id,schedule_date:@datas.schedule_date,start_time:@datas.start_time.to_time.strftime("%H:%M"),end_time:@datas.end_time.to_time.strftime("%H:%M"),avalailbecount:@datas.avalailbecount,status:@datas.status,remaining_num:@datas.remaining_num}
        #elsif table_name == 'AppointmentArrange'
        #  app_data = {id:@datas.id,schedule_id:@datas.schedule_id,time_arrange:@datas.time_arrange.to_time.strftime("%H:%M"),doctor_id:@datas.doctor_id,schedule_date:@datas.schedule_date,status:@datas.status,modality_device_id:@datas.modality_device_id}
        else
          app_data = @datas.as_json(:except => [:created_at,:updated_at])
        end
        render :json => {success: true, data: app_data}
      else
        render json: {success: false, data: ''}
      end
    end
  end

  def sync_result_create
    fk=params[:fk]
    status=params[:status]
    table_name=params[:table_name]
    code=params[:code]
    content=params[:content]
    @sync_result = MimasDatasyncResult.create(fk:fk,status:status,table_name:table_name,code:code,content:content)
    render json:{success:true}
  end

end

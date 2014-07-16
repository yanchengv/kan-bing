#encoding:utf-8
class ScheduleTemplatesController < ApplicationController
  before_filter :signed_in_user
  def create
    flash[:success]=nil
    number = params[:schedule][:avalailbecount].to_i
    dayofweek = params[:schedule][:schedule_day]
    start_time =  params[:schedule][:start_time].to_time
    end_time = params[:schedule][:end_time].to_time
    if start_time < end_time
      @schedule_template = ScheduleTemplate.where(dayofweek:dayofweek,doctor_id:current_user.doctor_id)
      if !@schedule_template.nil? && !@schedule_template.empty?
        @schedule_template.each do |appsch|
          if ((appsch.start_time.strftime("%H:%M:%S").to_time)-start_time<=0 && start_time-(appsch.end_time.strftime("%H:%M:%S").to_time)<0) || ((appsch.start_time.strftime("%H:%M:%S").to_time)-end_time<0 && end_time-(appsch.end_time.strftime("%H:%M:%S").to_time)<=0) || ((appsch.start_time.strftime("%H:%M:%S").to_time)-start_time>0 && end_time-(appsch.end_time.strftime("%H:%M:%S").to_time)>0)
            flash[:success]='预约安排添加失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
            msg = '预约安排添加失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
            #render :json => {success:false,msg:msg}
            redirect_to :back
            return
          end
        end
      end
      flash[:success]='预约安排添加成功！'
      @scheduleTemplate = ScheduleTemplate.new(doctor_id:current_user.doctor_id,dayofweek:dayofweek,start_time:start_time,end_time:end_time,number:number)
      @scheduleTemplate.save
      #render :json => {success:true,msg:@scheduleTemplate}
    else
      msg='预约安排添加失败！开始时间必须小于结束时间！'
      flash[:success]='预约安排添加失败！开始时间必须小于结束时间！'
      #render :json => {success:false,msg:msg}
    end
    redirect_to :back
  end


  def show_template
    @templates = ScheduleTemplate.where(doctor_id:current_user.doctor_id)
    render  :template => 'appointment_schedules/show_template'
  end

  def get_schedule_template
    @template = ScheduleTemplate.find_by(id:params[:id])
    render partial: 'appointment_schedules/show_schedule_template'
  end

  def update_template
    number=params[:app][:avalailbecount]
    dayofweek=params[:app][:app_day]
    start_time=params[:app][:start_time]
    end_time=params[:app][:end_time]
    if params[:app][:start_time].to_time < params[:app][:end_time].to_time
      @tem_schedule = ScheduleTemplate.where(dayofweek:params[:app][:app_day],doctor_id:current_user.doctor_id)
      if !@tem_schedule.nil?
        @tem_schedule.each do |sch|
          if sch.id != params[:app][:template_id].to_i
            if (sch.start_time.strftime("%H:%M:%S").to_time<=params[:app][:start_time].to_time && params[:app][:start_time].to_time<sch.end_time.strftime("%H:%M:%S").to_time) || (sch.start_time.strftime("%H:%M:%S").to_time<params[:app][:end_time].to_time && params[:app][:end_time].to_time<=sch.end_time.strftime("%H:%M:%S").to_time) || (sch.start_time.strftime("%H:%M:%S").to_time>params[:app][:start_time].to_time && params[:app][:end_time].to_time>sch.end_time.strftime("%H:%M:%S").to_time)
              msg = '修改失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
              flash[:success]='修改失败！该时间段与已安排的计划有冲突，请重新选择安排时间。'
              #render :json => {success:false,msg:msg}
              return
            end
          end
        end
      end
      template = ScheduleTemplate.find_by(id:params[:app][:template_id])
      template.update_attributes(number:number,dayofweek:dayofweek,start_time:start_time,end_time:end_time)
      flash[:success]='修改成功！'
      #render :json => {success:true,msg:template}
    else
      msg = '修改失败！开始时间必须小于结束时间！'
      flash[:success]='修改失败！开始时间必须小于结束时间！'
      #render :json => {success:false,msg:msg}
    end
    redirect_to :back
  end

  def destroy_template
    @schedule_template = ScheduleTemplate.find_by_id(params[:id])
    #@app_sch = @schedule_template
    @schedule_template.destroy
    flash[:success]='成功删除！'
    #render :json => @app_sch
    redirect_to :back
  end
end

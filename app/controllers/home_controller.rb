class HomeController < ApplicationController
  before_filter :signed_in_user,only: [:home]
  def index
    hospital_id=params[:hos]
    department_id=params[:dept]
    if signed_in?
      redirect_to action:'home'
    elsif !hospital_id.nil? || !department_id.nil?
        render layout: 'mapp'
       # @page_block=PageBlock.where('hospital_id=? AND department_id=? AND is_show=?',hospital_id,department_id,true).order(position: :asc)
       # render template:'home/center' and return
    end
  end
  def index2
    render 'index2'
  end
  def home
    @user0 = User.new
    @photos=""
    if !current_user.nil? && !current_user.doctor_id.nil?
      @name=current_user.doctor.name
      @photos = current_user.doctor.photo
      if !@photos.nil?&&@photos!=''
        @photos = current_user.doctor.photo
      else
        @photos='default.png'
      end
      @user = current_user.doctor
      #@videos=EduVideo.all
      @new_notes = @user.notes.order("created_at desc").limit(5).publiced
      @notes = @user.notes.order('is_top desc').limit(5).publiced
      @consult_questions = current_user.by_consult_questions.order('created_at desc').limit(5)#.paginate(:per_page => 9, :page => params[:page]) #医生的相关咨询
      @video_types=EduVideo.select("video_type_id,sum(id)").group("video_type_id").order("video_type_id desc")
      render :template => 'doctors/home'
      #redirect_to  controller:'doctors',action:'show_friends',type:1
    elsif !current_user.nil? && !current_user.patient_id.nil?
      @master_doctor = Doctor.where(:id => current_user.patient.doctor_id).first   #主治医生
      @doctors = current_user.patient.docfriends   #医生好友
      @name=current_user.patient.name
      @photos=current_user.patient.photo
      if !@photos.nil?&&@photos!=''
        @photos = current_user.patient.photo
      else
        @photos='default.png'
      end

      @is_record_table=false #主页面不显示血压,血糖的table列表
      @user = current_user.patient
      patient_id=current_user.patient_id
      @notes = current_user.receive_share_notes
      @consult_questions = current_user.create_consult_questions.order('created_at desc').limit(5)
      #@glucose_data=BloodGlucose.new.all_blood_glucoses(patient_id)
      #pressure_data=BloodPressure.new.get_blood_pressure(patient_id)
      #@systolic_pressure_data=pressure_data[:pressure_data][:systolic_pressure_data]
      #@diastolic_pressure_data=pressure_data[:pressure_data][:diastolic_pressure_data]
      #@weight_data=Weight.new.get_weight(patient_id)
      #
      #@blood_oxygen_all=BloodOxygen.where('patient_id=?',patient_id).order(measure_time: :asc)
      #@blood_oxygen_data=BloodOxygen.new.all_blood_oxygen(patient_id)
      render :template => 'patients/home'
      #redirect_to controller:'patients',action:'show_doctors',type:2
  else
  end
  end




end


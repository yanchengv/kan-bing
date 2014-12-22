#encoding:utf-8
class HomeController < ApplicationController
  before_filter :signed_in_user,only: [:home]
  layout "mapp", :only => :index
  layout "kanbing365" ,:only =>"index2"

  # def index
  #   hospital_id=params[:hos]
  #   department_id=params[:dept]
  #   if signed_in?
  #     redirect_to action:'home'
  #   elsif !hospital_id.nil? || !department_id.nil?
  #       @page_block=PageBlock.where('hospital_id=? AND department_id=? AND is_show=?',hospital_id,department_id,true).order(position: :asc)
  #       # render template:'home/center' and return
  #       render template:'home/center',layout:'mapp' and return
  #   else
  #
  #   end
  # end
  def index2
    @index_provinces = Province.indexpage_and_asc
    @hospitals =[]
    if !@index_provinces.nil?
      @index_provinces.each_with_index do |province ,index|
          province_id = province.id
          #province_name = province.name
          if !province_id.nil?
            hosps = Hospital.where(:province_id => province_id).limit(11)
            if !hosps.nil?
              @hospitals << hosps
            else
              @hospitals << {}
            end

          end
      end
    end
    @skills = Skill.all.limit(3)

    hospital_id=nil
    department_id=nil
    host=request.host
    @domain=Domain.where(name:host).first
    if  @domain
      hospital_id= @domain.hospital_id
      department_id=@domain.department_id
    elsif  !params[:hos].nil?|| !params[:dept].nil?
      # 用於測試
      hospital_id= params[:hos]
      department_id=params[:dept]
    else

    end

    # if host=="kangbing365.gre-medical.org"
    #   # hospital_id=Settings.kangbing365_gre_medical_org.hospital_id
    #   # department_id= Settings.kangbing365_gre_medical_org.department_id
    #   hospital_id=nil
    #   department_id=nil
    #   elsif host=='yuquan.gre-medical.org'
    #     hospital_id=Settings.yuquan_kanbing365_com.hospital_id
    #     department_id=Settings.yuquan_kanbing365_com.department_id
    #   else
    #      hospital_id=params[:hos]
    #      department_id=params[:dept]
    # end

    if signed_in?
      redirect_to action:'home'
    elsif !hospital_id.nil? || !department_id.nil?
      @page_block=PageBlock.where('hospital_id=? AND department_id=? AND is_show=?',hospital_id,department_id,true).order(position: :asc)
      render template:'home/center',layout:'mapp' and return
    else
      #中心 首页面 获取省份

      #@index_hospitals
      render 'index2'  #,    :layout => false
    end

  end


  def more
    render 'more'
  end
  def m_list
    render 'home/medical_technology'
  end
  def hos
    q1 = params[:city_name].to_s
    q2 = params[:province_name].to_s
    @hospitallists = Hospital.where(:province_name => q2)
    @hospitallists = @hospitallists.paginate(:page => 1, :per_page => 10)
    p  @hospitallists.count
    render 'hos_list'
  end
  def hos_c
    render 'hos_list_content'
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


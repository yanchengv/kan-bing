#encoding:utf-8
class HealthRecordsController < ApplicationController
  require 'open-uri'
  delegate "default_access_url_prefix_with", :to => "ActionController::Base.helpers"
  before_filter :signed_in_user, :except => [:create_health_data]
  skip_before_filter :verify_authenticity_token ,only:[:upload, :create_health_data,:upload2]
  #before_filter :user_health_record_power, only: [:ct,:ultrasound,:inspection_report]
  def play_video
    @video_url = video_access_url_prefix_with(params[:video_url])
    #url = params[:video_url].split('.')[0]
    #@video_url = Settings.edu_video + url[1,2] + '/' + url[4,2] + '/' + url[7,2] + '/' + url[10,30]
  end

  def go_where
    if  !params[:uuid].nil? && !params[:child_type].nil?
      case params[:child_type]
        when 'CT'
          redirect_to "/health_records/ct?child_id=#{params[:child_id]}&inspection_type=CT"
          #redirect_to '/health_records/ct?uuid='+params[:uuid]
        when '超声'
            redirect_to "/health_records/ultrasound?uuid=#{params[:uuid]}&child_id=#{params[:child_id]}"
        when '检验报告'
          redirect_to '/health_records/inspection_report?uuid='+params[:uuid]
        when '核磁','MR'
          redirect_to "/health_records/mri?child_id=#{params[:child_id]}&inspection_type=MR"
          #redirect_to '/health_records/mri?uuid='+params[:uuid]
        when '心电图'
          redirect_to '/ecg/show?ecg_id='+params[:uuid]
      end
    else
      redirect_to  root_path   :notice => "请求出现异常"
    end
  end

  def ct
    @obj ||= params[:child_id]
    @inspection_type = params[:inspection_type]
    #@obj ||= params[:uuid]
  end

  # 核磁
  def mri
    @obj ||= params[:child_id]
    @inspection_type = params[:inspection_type]
    #@obj ||= params[:uuid]
  end


  def ultrasound
    @uuid = params[:uuid]
    @iu = InspectionUltrasound.find(params[:child_id])
    @pics = @iu.image_list.split(',')
    @videos = @iu.video_list.split(',')
    @flag = false
    if !@uuid.nil? && @uuid != ''
      @flag=aliyun_file_exit(@uuid,'mimas-img')
    end
    #uuid = @uuid.split('.')[0]
    #@uuid = uuid+'.png'
    #@pic = []
    #is_more = true
    #num = 1
    #@uuidObj = Uuid.new
    #while is_more
    #  file_path = Settings.files_mount + 'png/' + @uuidObj.parse_uuid(uuid)+"_#{num}.png"
    #  if File.exist?(file_path)
    #    @pic << uuid+"_#{num}.png"
    #    num+=1
    #  else
    #    is_more = false
    #  end
    #end
    #@pics = @pic.join(',')
    # render template: 'health_records/ultrasound2'
  end

  def inspection_report
    @uuid = params[:uuid]
    @uuid = @uuid.split('.')[0]+'.png'
  end

  def get_video
    send_data data.read, type: "application/x-shockwave-flash", disposition: "inline", stream: "true"
  end




  def get_data
    patient_id = session["patient_id"]
    irs = InspectionReport.where("patient_id = ?", patient_id).length
    cts = InspectionCt.where("patient_id = ?", patient_id).length
    ults = InspectionUltrasound.where("patient_id = ?", patient_id).length
    nms = InspectionNuclearMagnetic.where("patient_id = ?", patient_id).length
    inds = InspectionData.where("patient_id = ?", patient_id).length
    ecg_num= Ecg.where("patient_id=?",patient_id).length
    slzb_num=ecg_num
    data = {
        "ct" => cts,
        "ult" => ults,
        "nm" => nms,
        "dicom" => cts+ults+nms,
        "ins_report" => inds,
        "ins" => inds,
        "all" => irs,
        "slzb_num"=>slzb_num,
        "ecg_num"=>ecg_num
    }
    render json: {data: data}
  end

  def dicom
    @irs = InspectionReport.
        where("patient_id = ?", session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/dicom'
  end

  def inspection
    @irs = InspectionReport.
        where("patient_id = ? and (child_type = ? or child_type = ? or child_type = ?)",session["patient_id"],'CT','超声','核磁',).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/dicom'
  end

  def ct2
    #@irs = InspectionReport.
    #    where("patient_id = ? and child_type = ? ",session["patient_id"],'CT').
    #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    @irs = InspectionCt.
        where("patient_id = ?",session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ct'
  end
   def mri2
     #@irs = InspectionReport.
     #    where("patient_id = ? and child_type = ? ",session["patient_id"],'核磁').
     #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
     @irs = InspectionNuclearMagnetic.
         where("patient_id = ?",session["patient_id"]).
         paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
     render partial: 'health_records/mri'
   end

  def ultrasound2
    #@irs = InspectionReport.
    #    where("patient_id = ? and child_type = ? ",session["patient_id"],'超声').
    #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    @irs = InspectionUltrasound.
        where("patient_id = ?",session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/ultrasound'
  end

  def inspection_report2
    #@irs = InspectionReport.
    #    where("patient_id = ? and child_type = ? ",session["patient_id"],'检验报告').
    #    paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    @irs = InspectionData.
        where("patient_id = ?",session["patient_id"]).
        paginate(:per_page => 20, :page => params[:page], :order => 'checked_at DESC')
    render partial: 'health_records/inspection_report'
  end

  def undefined_other
    render partial: 'health_records/undefined_other'
  end

  def upload
    b = false
    archive_type = params[:archivetype]
    stamp = DateTime.parse(Time.now.to_s).strftime("%T")
    upload_path = "uploads/cts/" << Date.today.to_s
    target_dir = Rails.root.join('public', upload_path)
    FileUtils.mkdir_p(target_dir)

    if !params[:fileToUpload].nil?
      if current_user.patient_id.nil?  && (!current_user.doctor_id.nil?)
        pat_id = params[:id]
        udoctor = current_user.doctor
      elsif !current_user.patient_id.nil? &&(current_user.doctor_id.nil?)
        pat_id = current_user.patient_id
        udoctor = current_user.patient.doctor
      end
      if !udoctor.nil?
        if !udoctor.hospital.nil?
          hospital_id = udoctor.hospital.id
          hospital_name = udoctor.hospital.name
        end

        if !udoctor.department.nil?
          department_id = udoctor.department.id
          department_name = udoctor.department.name
        end
        doctor_id = udoctor.id
        doctor_name = udoctor.name
      else
        hospital_id = ''
        hospital_name = ''
        department_id = ''
        department_name = ''
        doctor_id = ''
        doctor_name = ''
      end
      patient_name =  Patient.exists?(pat_id)?  Patient.find(pat_id).name: "unknownpatient"
      uploaded_io = params[:fileToUpload]
      filename1 = uploaded_io.original_filename
      filename = stamp << "-" << patient_name << "-" << filename1
      begin
        File.open(Rails.root.join('public', upload_path, filename), 'wb') do |file|
          file.write(uploaded_io.read)
          b = true
        end

        ArchiveQueue.create(
            :upload_user_id => current_user.id,
            :upload_user_name => current_user.name,
            :parent_type => "超声影像",
            :child_type => archive_type,
            :filename => upload_path << "/"<< filename,
            :filesize => uploaded_io.size,
            :extname => File.extname(filename1),
            :hospital_id => hospital_id,
            :hospital_name => hospital_name,
            :department_id => hospital_id,
            :department_name => department_name,
            :doctor_id => doctor_id,
            :doctor_name => doctor_name,
            :patient_id => pat_id,
            :patient_name => patient_name,
            :status => 1)
      rescue StandardError => e
        puts e
      ensure
        tempfile = uploaded_io.tempfile.path
        #p  "tmp file path is :"  <<  tempfile << "file exits? " << File.exists?(tempfile).to_s
        if File.exists?(tempfile)
          File.delete(tempfile)
        end
      end

    end

    if b
      render :text => ({:error => "",:msg => "文件上传成功,后台正在处理中请耐心等待处理结果"}.to_json)
    else
      render :text => ({:error => "true", msg: "文件类型错误或者存在异常"}.to_json)
    end

  end
  #显示dicom上传
  def show_upload
      @patient_id=params[:patient_id]
  end

   #dicom上传
  def upload2
    guid=params[:guid]
    patient_id=params[:patient_id]
    patient_id=patient_id.gsub(" ","+")
    patient_id=AES.decrypt(patient_id.to_s,Settings.key)  #aes解密
    guid2=SecureRandom.uuid
    upload_path = "uploads/dicom/"
    file_dir = Rails.root.join('public', upload_path)
    FileUtils.mkdir_p(file_dir)
    uploaded_io=params[:file]
    filename=params[:name]<<guid2
    File.open(Rails.root.join('public', upload_path,filename), 'wb') do |file|
      file.write (uploaded_io.read)
    end
    # 文件的本地路徑
      file_url="#{Rails.root}/public/uploads/dicom/#{filename}"
      if !current_user.doctor_id.nil?
          upload_user_id=current_user.doctor_id
      end
     @flag=HealthRecord.new.upload_to patient_id,file_url,upload_user_id
      if @flag==true
        # 上傳成功後刪除本地文件
        if File.exists?("#{Rails.root}/public/uploads/dicom/#{filename}")
          File.delete("#{Rails.root}/public/uploads/dicom/#{filename}")
        end
      else
        if File.exists?("#{Rails.root}/public/uploads/dicom/#{filename}")
          File.delete("#{Rails.root}/public/uploads/dicom/#{filename}")
        end
        @flag=false
      end

    render json:@flag
  end


  #该方法是患者生成对应的健康档案信息(这些信息只用于测试或展示)
  def create_health_data
    str = params[:str]
    if !str.nil? && str != ''
      @patients = Patient.where(" id = ? or mobile_phone = ? ", str, str)
      zxj_id = 113932081081001 #患者张小军的ID
      @patients.each do |pat|
        BloodFat.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        BloodGlucose.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        BloodOxygen.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        BloodPressure.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        Weight.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        Bme.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        BodyAge.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        Bfr.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        Vfl.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        Ecg.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        InspectionReport.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        InspectionData.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        InspectionCt.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        InspectionNuclearMagnetic.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        InspectionUltrasound.where("patient_id = #{pat.id} and patient_id != #{zxj_id}").delete_all
        #血酯
        @blood_fats = BloodFat.where(:patient_id => zxj_id)
        @blood_fats.each do |fat|
          begin
            BloodFat.create(patient_id: pat.id, total_cholesterol: fat.total_cholesterol, triglyceride: fat.triglyceride, high_lipoprotein: fat.high_lipoprotein, low_lipoprotein: fat.low_lipoprotein, measure_time: fat.measure_time, is_sure: fat.is_sure)
          rescue
            puts 'BloodFat  create failture'
          end
        end

        #血糖
        @blood_glucoses = BloodGlucose.where(:patient_id => zxj_id)
        @blood_glucoses.each do |glucose|
          begin
            BloodGlucose.create(:patient_id => pat.id, :measure_value => glucose.measure_value, :measure_date => glucose.measure_date, :measure_time => glucose.measure_time, :mdevice => glucose.mdevice)
          rescue
            puts 'BloodGlucose  create failture'
          end
        end

        #血氧
        @blood_oxygens = BloodOxygen.where(:patient_id => zxj_id)
        @blood_oxygens.each do |oxy|
          begin
            BloodOxygen.create(:patient_id => pat.id, :pulse_rate => oxy.pulse_rate, :o_saturation => oxy.o_saturation, :pi => oxy.pi, :measure_time => oxy.measure_time, :mdevice => oxy.mdevice)
          rescue
            puts 'BloodOxygen  create failture'
          end
        end

        #血压
        @blood_pressures = BloodPressure.where(:patient_id => zxj_id)
        @blood_pressures.each do |pre|
          begin
            BloodPressure.create(:patient_id => pat.id, :heart_rate => pre.heart_rate, :measure_date => pre.measure_date, :measure_time => pre.measure_time, :systolic_pressure => pre.systolic_pressure, :diastolic_pressure => pre.diastolic_pressure, :mdevice => pre.mdevice)
          rescue
            puts 'BloodPressure  create failture'
          end
        end

        #体重
        @weights = Weight.where(:patient_id => zxj_id)
        @weights.each do |weight|
          begin
            Weight.create(:patient_id => pat.id, :weight_value => weight.weight_value, :measure_time => weight.measure_time, :mdevice => weight.mdevice, :height => weight.height, :bmi => weight.bmi, :bfr => weight.bfr, :smrwb => weight.smrwb, :vfl => weight.vfl, :body_age => weight.body_age, :bme => weight.bme)
          rescue
            puts 'Weight  create failture'
          end
        end

        #基础代谢
        @bmes = Bme.where(:patient_id => zxj_id)
        @bmes.each do |bme|
          begin
            Bme.create(:patient_id => pat.id, :measure_value => bme.measure_value, :measure_time => bme.measure_time, :is_true => bme.is_true, :mdevice => bme.mdevice)
          rescue
            puts 'Bme  create failture'
          end
        end
        # 身体年龄
        @body_ages = BodyAge.where(:patient_id => zxj_id)
        @body_ages.each do |body_age|
          begin
            BodyAge.create(:patient_id => pat.id, :measure_value => body_age.measure_value, :measure_time => body_age.measure_time, :is_true => body_age.is_true, :mdevice => body_age.mdevice)
          rescue
            puts 'BodyAge  create failture'
          end
        end

        #脂肪率
        @bfrs = Bfr.where(:patient_id => zxj_id)
        @bfrs.each do |bfr|
          begin
            Bfr.create(:patient_id => pat.id, :measure_value => bfr.measure_value, :measure_time => bfr.measure_time, :is_true => bfr.is_true, :mdevice => bfr.mdevice)
          rescue
            puts 'Bfr  create failture'
          end
        end
        #内脏脂肪指数
        @vfls = Vfl.where(:patient_id => zxj_id)
        @vfls.each do |vfl|
          begin
            Vfl.create(:patient_id => pat.id, :measure_value => vfl.measure_value, :measure_time => vfl.measure_time, :is_true => vfl.is_true, :mdevice => vfl.mdevice)
          rescue
            puts 'Vfl  create failture'
          end
        end
        #心电图
        @ecgs = Ecg.where(:patient_id => zxj_id)
        @ecgs.each do |ecg|
          begin
            @ecg = Ecg.create(:patient_id => pat.id, :ecg_img => ecg.ecg_img, :device_type => ecg.device_type, :measure_time => ecg.measure_time, :ahdId => ecg.ahdId, :mdevice => ecg.mdevice, :is_true => ecg.is_true, :int_ecg_img => ecg.int_ecg_img, :bit_ecg_img => ecg.bit_ecg_img, :hospital => ecg.hospital, :department => ecg.department, :doctor => ecg.doctor, :parent_type => ecg.parent_type, :child_type => ecg.child_type)
          rescue
            puts 'Ecg  create failture'
          end
        end
        #检验信息
        @inspection_datas = InspectionData.where(:patient_id => zxj_id)
        @inspection_datas.each do |ins|
          begin
            @data = InspectionData.create(:patient_id => pat.id, :parent_type => ins.parent_type, :child_type => ins.child_type, :thumbnail => ins.thumbnail, :identifier => ins.identifier, :created_at => ins.created_at, :doctor => ins.doctor, :hospital => ins.hospital, :department => ins.department, :upload_user_id => ins.upload_user_id, :upload_user_name => ins.upload_user_name, :checked_at => ins.checked_at, :updated_at => ins.updated_at, :image_list => ins.image_list, :video_list => ins.video_list, :study_body => ins.study_body)
          rescue
            puts 'InspectionData  create failture'
          end
        end
        #cts
        @inspection_cts = InspectionCt.where(:patient_id => zxj_id)
        @inspection_cts.each do |ct|
          begin
            @ct = InspectionCt.create(:patient_id => pat.id, :parent_type => ct.parent_type, :child_type => ct.child_type, :thumbnail => ct.thumbnail, :identifier => ct.identifier, :created_at => ct.created_at, :doctor => ct.doctor, :hospital => ct.hospital, :department => ct.department, :upload_user_id => ct.upload_user_id, :upload_user_name => ct.upload_user_name, :checked_at => ct.checked_at, :updated_at => ct.updated_at, :image_list => ct.image_list, :video_list => ct.video_list, :study_body => ct.study_body)
          rescue
            puts 'InspectionCt  create failture'
          end
        end
        #
        #nuclear_magnetic  || MR
        @nuclear_magnetics = InspectionNuclearMagnetic.where(:patient_id => zxj_id)
        @nuclear_magnetics.each do |nm|
          begin
            @mic = InspectionNuclearMagnetic.create(:patient_id => pat.id, :parent_type => nm.parent_type, :child_type => nm.child_type, :thumbnail => nm.thumbnail, :identifier => nm.identifier, :created_at => nm.created_at, :doctor => nm.doctor, :hospital => nm.hospital, :department => nm.department, :upload_user_id => nm.upload_user_id, :upload_user_name => nm.upload_user_name, :checked_at => nm.checked_at, :updated_at => nm.updated_at, :image_list => nm.image_list, :video_list => nm.video_list, :study_body => nm.study_body)
          rescue
            puts 'InspectionNuclearMagnetic  create failture'
          end
        end
        #ultrasounds 超声
        @ultrasounds = InspectionUltrasound.where(:patient_id => zxj_id)
        @ultrasounds.each do |re|
          begin
            @inu = InspectionUltrasound.create(:patient_id => pat.id, :patient_name => pat.name, :patient_code => pat.spell_code, :parent_type => re.parent_type, :child_type => re.child_type, :thumbnail => re.thumbnail,
                                               :identifier => re.identifier, :doctor => re.doctor, :hospital => re.hospital,
                                               :department => re.department, :upload_user_id => re.upload_user_id, :upload_user_name => re.upload_user_name,
                                               :image_list => re.image_list, :video_list => re.video_list, :study_body => re.study_body, :patient_ids => pat.patient_ids, :apply_department_id => re.apply_department_id, :apply_department_name => re.apply_department_name, :apply_doctor_id => re.apply_doctor_id, :apply_doctor_name => re.apply_doctor_name, :bed_no => re.bed_no,
                                               :examined_part_name => re.examined_part_name, :examined_item_name => re.examined_item_name, :charge_type => re.charge_type, :charge => re.charge, :examine_doctor_id => re.examine_doctor_id, :examine_doctor_name => re.examine_doctor_name,
                                               :examine_doctor_code => re.examine_doctor_code, :qc_doctor_id => re.qc_doctor_id, :qc_doctor_name => re.qc_doctor_name, :is_emergency => re.is_emergency, :modality_device_id => re.modality_device_id, :initial_diagnosis => re.initial_diagnosis,
                                               :qc_status => re.qc_status, :check_start_time => re.check_start_time, :check_end_time => re.check_end_time, :print_count => re.print_count, :technician_id => re.technician_id, :technician_name => re.technician_name, :inputer_id => re.inputer_id,
                                               :inputer_name => re.inputer_name, :report_image_list => re.report_image_list, :us_finding => re.us_finding, :us_diagnose => re.us_diagnose, :statics => re.statics, :station_fee => re.station_fee, :report_print_fee => re.report_print_fee, :item_fee => re.item_fee, :desc_fee => re.desc_fee, :_id => re._id)
          rescue
            puts 'InspectionUltrasound  create failture'
          end
        end
      end
      render :json => {:success => true}
    else
      render :json => {:success => false, :error => '请输入ID 或 手机号'}
    end


  end

  private
  #判断有无权限读取某一患者的超声报告
  def user_health_record_power
    @ips = InspectionReport.where('thumbnail=?',params[:uuid])
    is_equal = false
    unless @ips.empty?
      @ip = @ips.first
      if !current_user.patient_id.nil?
        is_equal = true if current_user.patient_id == @ip.patient_id
      else !current_user.doctor_id.nil?
        is_equal = true if (!Patient.where('id=? and doctor_id=?',@ip.patient_id,current_user.doctor_id).empty? || !TreatmentRelationship.where('doctor_id=? and patient_id=?',current_user.doctor_id,@ip.patient_id).empty?)
      end
    end
    redirect_to '/' unless is_equal
  end
end

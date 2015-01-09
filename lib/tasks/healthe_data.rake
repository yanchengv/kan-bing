#encoding:utf-8
namespace :db do
  task health: :environment do
    #血酯
    save_health_data
  end
end

def save_health_data
  @doctor = Doctor.find(113932081080001) #田军医生
  @patients = {}
  @cont_main_users = @doctor.patients
  @cont_users = @doctor.patfriends
  @patients = @cont_main_users << @cont_users
  zxj_id = 113932081081001   #患者张小军的ID

  @patients.where("id != 113932081081001").each do |pat|
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
      BloodFat.create(patient_id: pat.id, total_cholesterol: fat.total_cholesterol, triglyceride: fat.triglyceride, high_lipoprotein: fat.high_lipoprotein, low_lipoprotein: fat.low_lipoprotein, measure_time: fat.measure_time, is_sure: fat.is_sure)
   end

   #血糖
   @blood_glucoses = BloodGlucose.where(:patient_id => zxj_id)
   @blood_glucoses.each do |glucose|
      BloodGlucose.create(:patient_id => pat.id, :measure_value => glucose.measure_value, :measure_date => glucose.measure_date, :measure_time => glucose.measure_time, :mdevice => glucose.mdevice)
   end

   #血氧
   @blood_oxygens = BloodOxygen.where(:patient_id => zxj_id)
   @blood_oxygens.each do |oxy|
      BloodOxygen.create(:patient_id => pat.id, :pulse_rate => oxy.pulse_rate, :o_saturation => oxy.o_saturation, :pi => oxy.pi, :measure_time => oxy.measure_time, :mdevice => oxy.mdevice)
   end

   #血压
   @blood_pressures = BloodPressure.where(:patient_id => zxj_id)
   @blood_pressures.each do |pre|
      BloodPressure.create(:patient_id => pat.id , :heart_rate => pre.heart_rate, :measure_date => pre.measure_date, :measure_time => pre.measure_time, :systolic_pressure => pre.systolic_pressure, :diastolic_pressure => pre.diastolic_pressure, :mdevice => pre.mdevice)
   end

   #体重
   @weights = Weight.where(:patient_id => zxj_id)
   @weights.each do |weight|
      Weight.create(:patient_id => pat.id, :weight_value => weight.weight_value, :measure_time => weight.measure_time, :mdevice => weight.mdevice, :height => weight.height, :bmi => weight.bmi, :bfr => weight.bfr, :smrwb => weight.smrwb, :vfl => weight.vfl, :body_age => weight.body_age, :bme => weight.bme)
   end

   #基础代谢
   @bmes = Bme.where(:patient_id => zxj_id)
   @bmes.each do |bme|
      Bme.create(:patient_id => pat.id, :measure_value => bme.measure_value, :measure_time => bme.measure_time, :is_true => bme.is_true, :mdevice => bme.mdevice)
   end
   # 身体年龄
   @body_ages = BodyAge.where(:patient_id => zxj_id)
   @body_ages.each do |body_age|
      BodyAge.create(:patient_id => pat.id, :measure_value => body_age.measure_value, :measure_time => body_age.measure_time, :is_true => body_age.is_true, :mdevice => body_age.mdevice)
   end

   #脂肪率
   @bfrs = Bfr.where(:patient_id => zxj_id)
   @bfrs.each do |bfr|
      Bfr.create(:patient_id => pat.id, :measure_value => bfr.measure_value, :measure_time => bfr.measure_time, :is_true => bfr.is_true, :mdevice => bfr.mdevice)
   end
   #内脏脂肪指数
   @vfls = Vfl.where(:patient_id => zxj_id)
   @vfls.each do |vfl|
      Vfl.create(:patient_id => pat.id, :measure_value => vfl.measure_value, :measure_time => vfl.measure_time, :is_true => vfl.is_true, :mdevice => vfl.mdevice)
   end
   #心电图
   @ecgs = Ecg.where(:patient_id => zxj_id)
   @ecgs.each do |ecg|
      Ecg.create(:patient_id => pat.id, :ecg_img => ecg.ecg_img, :device_type => ecg.device_type, :measure_time => ecg.measure_time, :ahdId => ecg.ahdId, :mdevice => ecg.mdevice, :is_true => ecg.is_true, :int_ecg_img => ecg.int_ecg_img, :bit_ecg_img => ecg.bit_ecg_img, :hospital => ecg.hospital, :department => ecg.department, :doctor => ecg.doctor, :parent_type => ecg.parent_type, :child_type => ecg.child_type)
   end

    #健康档案所有信息
    @inspection_reports = InspectionReport.where(:patient_id => zxj_id)
    @inspection_reports.each do |report|
      InspectionReport.create(:patient_id => pat.id, :parent_type => report.parent_type, :child_type => report.child_type, :thumbnail => report.thumbnail, :identifier => report.identifier, :created_at => report.created_at, :doctor => report.doctor, :hospital => report.hospital, :department => report.department, :child_id => report.child_id, :upload_user_id => report.upload_user_id, :upload_user_name => report.upload_user_name, :checked_at => report.checked_at, :updated_at => report.updated_at, :image_list => report.image_list, :video_list => report.video_list, :study_body => report.study_body)
    end

    #检验信息
    @inspection_datas = InspectionData.where(:patient_id => zxj_id)
    @inspection_datas.each do |ins|
      InspectionData.create(:patient_id => pat.id, :parent_type => ins.parent_type, :child_type => ins.child_type, :thumbnail => ins.thumbnail, :identifier => ins.identifier, :created_at => ins.created_at, :doctor => ins.doctor, :hospital => ins.hospital, :department => ins.department, :upload_user_id => ins.upload_user_id, :upload_user_name => ins.upload_user_name, :checked_at => ins.checked_at, :updated_at => ins.updated_at, :image_list => ins.image_list, :video_list => ins.video_list, :study_body => ins.study_body)
    end

    #cts
    @inspection_cts = InspectionCt.where(:patient_id => zxj_id)
    @inspection_cts.each do |ct|
      InspectionCt.create(:patient_id => pat.id, :parent_type => ct.parent_type, :child_type => ct.child_type, :thumbnail => ct.thumbnail, :identifier => ct.identifier, :created_at => ct.created_at, :doctor => ct.doctor, :hospital => ct.hospital, :department => ct.department, :upload_user_id => ct.upload_user_id, :upload_user_name => ct.upload_user_name, :checked_at => ct.checked_at, :updated_at => ct.updated_at, :image_list => ct.image_list, :video_list => ct.video_list, :study_body => ct.study_body)
    end

    #nuclear_magnetic
    @nuclear_magnetics = InspectionNuclearMagnetic.where(:patient_id => zxj_id)
    @nuclear_magnetics.each do |nm|
      InspectionNuclearMagnetic.create(:patient_id => pat.id, :parent_type => nm.parent_type, :child_type => nm.child_type, :thumbnail => nm.thumbnail, :identifier => nm.identifier, :created_at => nm.created_at, :doctor => nm.doctor, :hospital => nm.hospital, :department => nm.department, :upload_user_id => nm.upload_user_id, :upload_user_name => nm.upload_user_name, :checked_at => nm.checked_at, :updated_at => nm.updated_at, :image_list => nm.image_list, :video_list => nm.video_list, :study_body => nm.study_body)
    end

    #ultrasounds
    @ultrasounds = InspectionUltrasound.where(:patient_id => zxj_id)
    @ultrasounds.each do |re|
      InspectionUltrasound.create(:patient_id => pat.id, :parent_type => re.parent_type, :child_type => re.child_type, :thumbnail => re.thumbnail, :identifier => re.identifier, :created_at => re.created_at, :doctor => re.doctor, :hospital => re.hospital, :department => re.department, :upload_user_id => re.upload_user_id, :upload_user_name => re.upload_user_name, :checked_at => re.checked_at, :updated_at => re.updated_at, :image_list => re.image_list, :video_list => re.video_list, :study_body => re.study_body)
    end
  end
end
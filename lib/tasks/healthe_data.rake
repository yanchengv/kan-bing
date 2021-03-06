#encoding:utf-8
namespace :db do
  task health: :environment do
    update_inspection_ultrasound
    #血酯
    save_health_data
  end
end

def update_inspection_ultrasound
  @ultrasounds = InspectionUltrasound.where(:patient_id => 113932081081001)
  @ul = @ultrasounds.first
  @ul.update_attributes(:apply_department_name => '神经外科一病区', :apply_doctor_name => '崔志强',:bed_no => 27,:source_code => 'GQ'+SecureRandom.random_number(8999).to_s,
                                            :examined_item_name => '腹部多系统(肝胆胰脾双肾+腹腔及腹膜后淋巴结)', :examine_doctor_name => '盛林',
                                             :inputer_name => '张肖平',:us_finding => '肝脏:体积正常,形态规整,右前叶下段可见一1.0x0.8cm的无回声囊,余实质回声均匀,肝内管道结构清晰;肝内胆管无扩张;门静脉内径正常.
胆囊缩小,大小3.6x1.6cm,壁厚,毛糙,壁上可见点状强回声,大小0.4cm.
胰腺:体积正常,形态规整,实质回声均匀,主胰管不扩张.
脾脏:体积正常,形态规整,实质厚度正常,回声正常,皮髓质界限清晰,集合系统未探及分离.
平卧们:腹腔扫查未探及明显游离液体.', :us_diagnose => '肝囊肿.
胆囊缩小,胆囊壁胆固醇结晶,符合慢性胆囊炎声像图改变.')
  @ultrasounds.where("id  != ? ", @ul.id).each do |ul|
    begin
    ul.update_attributes(:patient_name =>'张小军', :patient_code => 'zxj',:apply_department_name => '神经外科一病区', :apply_doctor_name => '崔志强', :bed_no => 27, :source_code => 'GQ'+SecureRandom.random_number(8999).to_s,
                      :examined_item_name => '腹部多系统(肝胆胰脾双肾+腹腔及腹膜后淋巴结)', :examine_doctor_name => '盛林',
                      :inputer_name => '张肖平', :us_finding => '肝脏:体积正常,形态规整,右前叶下段可见一1.0x0.8cm的无回声囊,余实质回声均匀,肝内管道结构清晰;肝内胆管无扩张;门静脉内径正常.
胆囊缩小,大小3.6x1.6cm,壁厚,毛糙,壁上可见点状强回声,大小0.4cm.
胰腺:体积正常,形态规整,实质回声均匀,主胰管不扩张.
脾脏:体积正常,形态规整,实质厚度正常,回声正常,皮髓质界限清晰,集合系统未探及分离.
平卧们:腹腔扫查未探及明显游离液体.', :us_diagnose => '肝囊肿.
胆囊缩小,胆囊壁胆固醇结晶,符合慢性胆囊炎声像图改变.')
    rescue
      puts "InspectionUltrasound  update failture------#{ul.id}"
    end
  end
end

def save_health_data
  @doctor = Doctor.find(113932081080001) #田军医生
  #@patients = {}
  #@cont_main_users = @doctor.patients
  #@cont_users = @doctor.patfriends
  #@patients = @cont_main_users << @cont_users.group(:id)
  @patients = Patient.select('distinct id, name, spell_code, gender, birthday, patient_ids').where("id != 113932081081001 and (doctor_id = ? or id in (select patient_id from treatment_relationships where doctor_id = ?))", 113932081080001, 113932081080001)
  zxj_id = 113932081081001   #患者张小军的ID
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
  #
  ##健康档案所有信息
  #@inspection_reports = InspectionReport.where(:patient_id => zxj_id)
  #@inspection_reports.each do |report|
  #   begin
  #     InspectionReport.create(:patient_id => pat.id, :parent_type => report.parent_type, :child_type => report.child_type, :thumbnail => report.thumbnail, :identifier => report.identifier, :created_at => report.created_at, :doctor => report.doctor, :hospital => report.hospital, :department => report.department, :child_id => report.child_id, :upload_user_id => report.upload_user_id, :upload_user_name => report.upload_user_name, :checked_at => report.checked_at, :updated_at => report.updated_at, :image_list => report.image_list, :video_list => report.video_list, :study_body => report.study_body)
  #   rescue
  #     puts 'InspectionReport  create failture'
  #   end
  #end
  #
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
                                           :identifier => re.identifier, :created_at => re.created_at, :doctor => re.doctor, :hospital => re.hospital,
                                           :department => re.department, :upload_user_id => re.upload_user_id, :upload_user_name => re.upload_user_name,
                                           :checked_at => re.checked_at, :updated_at => re.updated_at, :image_list => re.image_list, :video_list => re.video_list, :study_body => re.study_body,:patient_ids => pat.patient_ids, :apply_department_id => re.apply_department_id, :apply_department_name => re.apply_department_name, :apply_doctor_id => re.apply_doctor_id, :apply_doctor_name => re.apply_doctor_name, :bed_no => re.bed_no, :source_code => 'GQ'+SecureRandom.random_number(8999).to_s,
                                           :examined_part_name => re.examined_part_name, :examined_item_name => re.examined_item_name, :charge_type => re.charge_type, :charge => re.charge, :examine_doctor_id => re.examine_doctor_id, :examine_doctor_name => re.examine_doctor_name,
                                           :examine_doctor_code => re.examine_doctor_code, :qc_doctor_id => re.qc_doctor_id, :qc_doctor_name => re.qc_doctor_name, :is_emergency => re.is_emergency, :modality_device_id => re.modality_device_id, :initial_diagnosis => re.initial_diagnosis,
                                           :qc_status => re.qc_status, :check_start_time => re.check_start_time, :check_end_time => re.check_end_time, :print_count => re.print_count, :technician_id => re.technician_id, :technician_name => re.technician_name, :inputer_id => re.inputer_id,
                                           :inputer_name => re.inputer_name, :report_image_list => re.report_image_list, :us_finding => re.us_finding, :us_diagnose => re.us_diagnose, :statics => re.statics, :station_fee => re.station_fee, :report_print_fee => re.report_print_fee, :item_fee => re.item_fee, :desc_fee => re.desc_fee, :_id => re._id)
      rescue
        puts 'InspectionUltrasound  create failture'
      end
  end
  end
end
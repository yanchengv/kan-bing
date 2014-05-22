class BloodFatController < ApplicationController

  def show
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @is_record_table=true
    #切分数据
    count= BloodFat.where('patient_id=?',patient_id).count
    left_count=count-count/2
    right_count=count/2
    @blood_fat_data_left=BloodFat.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
    @blood_fat_data_right=BloodFat.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
    render partial: 'health_records/blood_fat'
  end
  def create
    @blood_fat=BloodFat.new
    @blood_fat.add_blood_fat params
    patient_id=current_user.patient_id
    render partial: 'health_records/blood_fat'
  end

  def all_blood_fat
    if current_user.doctor_id.nil?
      patient_id=current_user.patient_id
    else
      patient_id=session["patient_id"]
    end
    @blood_fat=BloodFat.new
    @blood_fat_data_all=@blood_fat.all_blood_fat patient_id
    render json:@blood_fat_data_all
  end
end

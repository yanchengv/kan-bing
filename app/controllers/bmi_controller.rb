 # 身体质量指数
 class BmiController < ApplicationController
   def show
     if current_user.doctor_id.nil?
       patient_id=current_user.patient_id
     else
       patient_id=session["patient_id"]
     end
     @is_record_table=true
     #切分数据
     count= Bmi.where('patient_id=?',patient_id).count
     left_count=count-count/2
     right_count=count/2
     @bmi_data_left=Bmi.where('patient_id=?',patient_id).order(measure_time: :asc).limit(left_count).offset(0)
     @bmi_data_right=Bmi.where('patient_id=?',patient_id).order(measure_time: :asc).limit(right_count).offset(left_count)
     render partial: 'health_records/bmi'
   end

   def create
     patient_id=current_user.patient_id
     @bmi=Bmi.new
     @bmi.add_bmi params
     @bmi=Bmi.where('patient_id=?',patient_id).order(measure_time: :asc)
     render partial: 'health_records/bmi'
   end

   def update
     patient_id=current_user.patient_id
     @bmi=Bmi.new
     @bmi.update_bmi params
     @bmi=Bmi.where('patient_id=?',patient_id).order(measure_time: :asc)
     render partial: 'health_records/bmi'
   end

   def all_bmi_data
     if current_user.doctor_id.nil?
       patient_id=current_user.patient_id
     else
       patient_id=session["patient_id"]
     end
     @bmi_data=Bmi.new.all_bmi_data(patient_id)
     render json:@bmi_data
   end

 end

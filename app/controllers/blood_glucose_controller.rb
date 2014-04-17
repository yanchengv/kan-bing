class BloodGlucoseController < ApplicationController
  def create
      blood= params
      patient_id=blood['patient_id']
      measure_value=blood['measure_value']
      measure_date=blood['measure_date']
      @blood_glucose=BloodGlucose.new(patient_id:patient_id,measure_value:measure_value,measure_date:measure_date)
      @blood_glucose.save

      @blood_glucose=BloodGlucose.new
      @blood_glucoses=BloodGlucose.where(patient_id:current_user.patient.id).order(measure_date: :asc)
      @blood_data=[]
      @blood_glucoses.each do |blood|
        blood_glu=[blood.measure_date.strftime("%Y-%m-%d %H:%M").to_time.to_i*1000,blood.measure_value.to_i]
        @blood_data.append blood_glu
      end
      render partial:'patients/show_blood_glucose'
  end

  def show
    @blood_glucoses=BloodGlucose.where(patient_id:current_user.patient.id).order(measure_date: :asc)
    @blood_data=[]
    @blood_glucoses.each do |blood|
      blood_glu=[blood.measure_date.strftime("%Y-%m-%d %H:%M:%S").to_time.to_i*1000,blood.measure_value.to_i]
      @blood_data.append blood_glu

    end
  end
end

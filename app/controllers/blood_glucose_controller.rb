class BloodGlucoseController < ApplicationController
  def create
      blood= params[:blood_glucose]
      patient_id=blood['patient_id']
      measure_value=blood['measure_value']
      measure_date=blood['measure_date']
      @blood_glucose=BloodGlucose.new(patient_id:patient_id,measure_value:measure_value,measure_date:measure_date)
      @blood_glucose.save
  end
end

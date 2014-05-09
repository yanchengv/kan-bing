class TreatmentRelationship < ActiveRecord::Base
  attr_accessible :doctor_id, :patient_id
  belongs_to :doctor
  belongs_to :patient
  def self.is_friends(doctor_id,patient_id)
    flag = false
    @patient = Patient.find(patient_id)
    if @patient.doctor_id == doctor_id.to_i
      flag = true
    end
    if flag == false
      @trs = TreatmentRelationship.where(:doctor_id => doctor_id,:patient_id => patient_id)
      if @trs.count > 0
        flag = true
      end
    end
    return flag
  end

end

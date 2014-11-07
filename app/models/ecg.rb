class Ecg < ActiveRecord::Base
  belongs_to :patient, :foreign_key => :patient_id
  attr_accessible  :id,:patient_id,:ecg_img ,:device_type ,:measure_time,:ahdId,:mdevice,:is_true,:int_ecg_img,:bit_ecg_img ,:hospital, :department,:doctor,:parent_type,:child_type
  after_save :inspection_report_ecg
  after_destroy :delete_inspection_report_ecg
end

def inspection_report_ecg

  inspection_report={}
      inspection_report[:patient_id]=self.patient_id
      inspection_report[:child_id]=self.id
      inspection_report[:parent_type]=self.parent_type
      inspection_report[:child_type]=self.child_type
      inspection_report[:hospital]=self.hospital
      inspection_report[:department]=self.department
      inspection_report[:doctor]=self.doctor
      inspection_report[:checked_at]=self.measure_time
     @inspection_report=InspectionReport.new(inspection_report)
     @inspection_report.save
end

def  delete_inspection_report_ecg
  @inspection_report=InspectionReport.where(patient_id:self.patient_id,parent_type:self.parent_type,child_type: self.child_type,child_id:self.id).first
  @inspection_report.destroy
end

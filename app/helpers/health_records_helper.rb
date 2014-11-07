module HealthRecordsHelper
  #子类数据添加或者删除之后 需要相应的添加删除inspection_reports总表
  #InspectionUltrasound.create(patient_id: 114139562695684,parent_type: "影像数据", child_type: "超声",
  #                            thumbnail: "111111.xml", doctor: "盛林",
  #                            hospital: "清华大学玉泉医院", department: "超声科", upload_doctor_id: "222222222",
  #                            upload_doctor_name: "测试",checked_at: "2011-09-27")
  def create_inspection_report
    InspectionReport.create(patient_id: self.patient_id,parent_type: self.parent_type, child_type: self.child_type,
                            thumbnail: self.thumbnail,  identifier: self.identifier, doctor: self.doctor,
                            hospital: self.hospital, department: self.department, upload_doctor_id: self.upload_doctor_id,
                            upload_doctor_name: self.upload_doctor_name,checked_at: self.checked_at, child_id: self.id
    )
  end
  def delete_inspection_report
    @inspection_report=InspectionReport.where(patient_id:self.patient_id,parent_type:self.parent_type,child_type: self.child_type,child_id:self.id).first
    @inspection_report.destroy
  end
end

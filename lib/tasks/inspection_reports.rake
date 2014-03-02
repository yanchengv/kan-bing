#encoding:utf-8
namespace :db do
  task seed: :environment do
    init_inspection_reports
  end
end
#创建健康档案seed数据
def init_inspection_reports
  InspectionReport.delete_all
  InspectionReport.create(
      id: 113932081080001,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '2fd5bbc128d14c18a73deb7cf7d9611e.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-07'
  )
  InspectionReport.create(
      id: 113932081080002,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '54e515e9dac54518989d9541e544f1de.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-08'
  )
  InspectionReport.create(
      id: 113932081080003,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '7b9e3c652eaa4abda50fb4a3fb9f499e.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-09'
  )
  InspectionReport.create(
      id: 113932081080004,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '3a33afd442ba41ff93ba7d751977ece5.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-10'
  )
  InspectionReport.create(
      id: 113932081080005,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '7ddd6fcd05f4478386420652d5cac961.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-11'
  )
  InspectionReport.create(
      id: 113932081080006,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '1c1e650ac9124d9c85f32514ad36de99.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-12'
  )
  InspectionReport.create(
      id: 113932081080007,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '0ba10afd39a4472199d3bb5105f39d6c.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-13'
  )
  InspectionReport.create(
      id: 113932081080008,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: 'bd7c9b44042e4ab6819ceec8027fb412.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-14'
  )
  InspectionReport.create(
      id: 113932081080009,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '40484b04bbb34e6faa66e9ede97e719d.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-15'
  )
  InspectionReport.create(
      id: 113932081080010,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '038b84930f394c189c8b532e047e725d.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-01-16'
  )
  InspectionReport.create(
      id: 113932081080011,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '2fd5bbc128d14c18a73deb7cf7d9611e.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-07'
  )
  InspectionReport.create(
      id: 113932081080012,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '54e515e9dac54518989d9541e544f1de.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-08'
  )
  InspectionReport.create(
      id: 113932081080013,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '7b9e3c652eaa4abda50fb4a3fb9f499e.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-09'
  )
  InspectionReport.create(
      id: 113932081080014,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '3a33afd442ba41ff93ba7d751977ece5.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-10'
  )
  InspectionReport.create(
      id: 113932081080015,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '7ddd6fcd05f4478386420652d5cac961.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-11'
  )
  InspectionReport.create(
      id: 113932081080016,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '1c1e650ac9124d9c85f32514ad36de99.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-12'
  )
  InspectionReport.create(
      id: 113932081080017,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '0ba10afd39a4472199d3bb5105f39d6c.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-13'
  )
  InspectionReport.create(
      id: 113932081080018,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: 'bd7c9b44042e4ab6819ceec8027fb412.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-14'
  )
  InspectionReport.create(
      id: 113932081080019,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '40484b04bbb34e6faa66e9ede97e719d.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-15'
  )
  InspectionReport.create(
      id: 113932081080020,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: '超声',
      thumbnail: '038b84930f394c189c8b532e047e725d.png',
      identifier: '',
      doctor: '田学军',
      hospital: '清华大学玉泉医院',
      department: '超声科',
      checked_at: '2014-02-16'
  )
  InspectionReport.create(
      id: 113932081080021,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-02-17'
  )
  InspectionReport.create(
      id: 113932081080022,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-01-17'
  )
  InspectionReport.create(
      id: 113932081080023,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-01-14'
  )
  InspectionReport.create(
      id: 113932081080024,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-02-14'
  )
  InspectionReport.create(
      id: 113932081080025,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-02-01'
  )
  InspectionReport.create(
      id: 113932081080026,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-02-09'
  )
  InspectionReport.create(
      id: 113932081080027,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-02-17'
  )
  InspectionReport.create(
      id: 113932081080028,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-01-08'
  )
  InspectionReport.create(
      id: 113932081080029,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-01-15'
  )
  InspectionReport.create(
      id: 113932081080030,
      patient_id: 113932081080001,
      parent_type: '影像数据',
      child_type: 'CT',
      thumbnail: '',
      identifier: '',
      doctor: '卜云芸',
      hospital: '清华大学玉泉医院',
      department: 'CT室',
      checked_at: '2014-01-12'
  )
end

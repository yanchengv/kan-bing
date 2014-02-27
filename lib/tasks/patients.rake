#encoding:utf-8
namespace :db do
  task seed: :environment do
    patients
  end
end

def patients
  Patient.delete_all

  @patient1 = Patient.create(
      id: 113932081080001,
      name: '张三丰',
      spell_code: '',
      credential_type: '身份证',
      credential_type_number: '410726198912203834',
      gender: '男',
      birthday: '1920-8-17',
      birthplace: '中国',
      address: '中国武当山',
      nationality: '',
      citizenship: '',
      province: '',
      county: '中国',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15201248938',
      home_phone: '',
      home_address: '',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'spfzzz@163.com',
      introduction: '',
      patient_ids: 'A'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor3.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )
  @patient2 = Patient.create(
      id: 113932081080002,
      name: '张无忌',
      spell_code: '',
      credential_type: '身份证',
      credential_type_number: '410726198912203831',
      gender: '男',
      birthday: '1920-8-11',
      birthplace: '中国',
      address: '中国武当山',
      nationality: '',
      citizenship: '',
      province: '',
      county: '中国',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15201248931',
      home_phone: '',
      home_address: '',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'zhangsanfeng@163.com',
      introduction: '',
      patient_ids: 'B'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor3.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )
  @patient3 = Patient.create(
      id: 113932081080003,
      name: '因素素',
      spell_code: '',
      credential_type: '身份证',
      credential_type_number: '410726198912203832',
      gender: '女',
      birthday: '1925-8-11',
      birthplace: '中国',
      address: '中国武当山',
      nationality: '',
      citizenship: '',
      province: '',
      county: '中国',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15201248932',
      home_phone: '',
      home_address: '',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'yinsusu@163.com',
      introduction: '',
      patient_ids: 'C'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor3.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )
  @patient4 = Patient.create(
      id: 113932081080004,
      name: '高元',
      spell_code: 'LW',
      credential_type: '身份证',
      credential_type_number: '110108197711263179',
      gender: '女',
      birthday: '1977-11-26',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '',
      marriage: '未婚',
      mobile_phone: '13381207909',
      home_phone: '010-123569856',
      home_address: '北京市石景山区5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'lishi@163.com',
      introduction: '',
      patient_ids: 'G'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor3.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )
  @patient5 = Patient.create(
      id: 113932081080005,
      name: '罗卿平',
      spell_code: 'GQ',
      credential_type: '身份证',
      credential_type_number: '220625199211241560',
      gender: '男',
      birthday: '1992-11-24',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15510302177',
      home_phone: '',
      home_address: '北京市石景山区5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'gaoqing@163.com',
      introduction: '',
      patient_ids: 'F'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor6.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )

  @patient6 = Patient.create(
      id: 113932081080006,
      name: '马志武',
      spell_code: 'ZM',
      credential_type: '身份证',
      credential_type_number: '632221199003082228',
      gender: '男',
      birthday: '1990-03-08',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '',
      marriage: '未婚',
      mobile_phone: '18210142581',
      home_phone: '',
      home_address: '北京市石景山区5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'zhangmei@163.com',
      introduction: '',
      patient_ids: 'D2'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor8.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )
  @patient7 = Patient.create(
      id: 113932081080007,
      name: '郭晋',
      spell_code: 'SY',
      credential_type: '身份证',
      credential_type_number: '130826198708011753',
      gender: '男',
      birthday: '1987-08-01',
      birthplace: '河北',
      address: '河北',
      nationality: '满族',
      citizenship: '中国',
      province: '河北',
      county: '河北某县',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15201007097',
      home_phone: '010-123569856',
      home_address: '北京市石景山区5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'guoj@163.com',
      introduction: '',
      patient_ids: 'D1'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor8.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )

  @patient8 = Patient.create(
      id: 113932081080008,
      name: '张重阳',
      spell_code: '',
      credential_type: '身份证',
      credential_type_number: '130826195408011753',
      gender: '男',
      birthday: '1954-08-01',
      birthplace: '河北',
      address: '河北',
      nationality: '满族',
      citizenship: '中国',
      province: '河北',
      county: '河北某县',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15201007097',
      home_phone: '010-123569856',
      home_address: '北京市石景山区5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'zcy@163.com',
      introduction: '',
      patient_ids: 'Y'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor6.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )

  @patient9 = Patient.create(
      id: 113932081080009,
      name: '黎少平',
      spell_code: 'SY',
      credential_type: '身份证',
      credential_type_number: '130826197208011753',
      gender: '男',
      birthday: '1972-08-01',
      birthplace: '山东',
      address: '山东',
      nationality: '满族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15201007097',
      home_phone: '010-123569856',
      home_address: '北京市石景山区5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'lsp@163.com',
      introduction: '',
      patient_ids: 'W'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor6.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )
  puts 'patients10'
  @patient10 = Patient.create(
      id: 113932081080010,
      name: '程亚和',
      spell_code: 'SY',
      credential_type: '身份证',
      credential_type_number: '130826197908011753',
      gender: '男',
      birthday: '1989-08-01',
      birthplace: '山东',
      address: '山东',
      nationality: '满族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '未婚',
      mobile_phone: '15201007797',
      home_phone: '010-123569856',
      home_address: '北京市石景山区5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'cyh@163.com',
      introduction: '',
      patient_ids: 'Q'+Time.new.to_i.to_s,
      education: '',
      household: '',
      doctor_id:@doctor5.id,
      occupation: '',
      orgnization: '',
      orgnization_address: '',
      insurance_type: '',
      insurance_number: ''
  )

end
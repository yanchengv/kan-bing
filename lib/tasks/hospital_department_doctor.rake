#encoding:utf-8
namespace :db do
  task seed: :environment do
    hospital_data
    make_doctors
  end
end


def hospital_data
  Hospital.delete_all
  @hospital1 = Hospital.create(
      id: '1',
      name: '清华大学玉泉医院',
      short_name: '玉泉医院',
      spell_code: 'YHDXYQYY',
      phone: '010-88257755',
      address: '北京石景山区石景山路5号',
      rank: '二级甲等',
      description: '<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 清华大学第二附属医院（清华大学玉泉医院）是一所向社会开放的二级甲等综合性医院，1983年12月建院，2003年4月10日划归清华大学，由著名的神经外科专家左焕琮教授担任院长。清华大学玉泉医院肿瘤会诊中心，是构建在国际最新肿瘤治疗技术平台基础上，以现代信息技术为手段，进行肿瘤国际会诊，手术规划，肿瘤微创治疗、综合治疗指导以及肿瘤康复的全新肿瘤个体化治疗的医学平台。</P>'
  )
  Department.delete_all
  @department1 = Department.create(
      id: 1,
      name: '肿瘤消融中心',
      short_name: '肿瘤科',
      spell_code: 'ZLXRZX',
      phone_number: '010-88254555',
      hospital_id: @hospital1.id,
      description: '自２００３年４月初 玉泉医院归入清华 大学 后  我科面临着前所未有的发展机遇  许多 国内 知名 影像 专家 被清华所属 医院所 具有 的远大发展前景而吸引  希望 参加 我院的二次创业  为把我院建成 国内 乃至世界一流医院做出自己的 贡献  预计到２００４年上半年  我科将引进学科带头人一名（ 博士 生 导师 ）   影像 学 博士 一名；２００４年下半年引进 国内名牌院校 影像 系 毕业生三名   '
  )
  @department2 = Department.create(
      id: 2,
      name: '放射影像科',
      short_name: '放射科',
      spell_code: 'FSYXK',
      phone_number: '010-88257235',
      hospital_id: @hospital1.id,
      description: '影像科现有14人，其中医师5人，技师6人，护士2人，登记员1人。我们长年聘请解放军总医院影像科著名教授每周来我科对疑难病例进行会诊、讲学。'
  )
  @department3 = Department.create(
      id: 3,
      name: '超声诊断科',
      short_name: '超声科',
      spell_code: 'CSZDK',
      phone_number: '010-88257455',
      hospital_id: @hospital1.id,
      description: '清华大学玉泉医院 超声诊断科 介绍信息暂无'
  )
  @department4 = Department.create(
      id: 4,
      name: '检验科',
      short_name: '检验科',
      spell_code: 'JYK',
      phone_number: '010-88223755',
      hospital_id: @hospital1.id,
      description: '清华大学玉泉医院 检验科 介绍信息暂无'
  )
  @department8 = Department.create(
      id: 8,
      name: '麻醉科',
      short_name: '麻醉科',
      spell_code: 'MZK',
      phone_number: '57976770',
      hospital_id: @hospital1.id,
      description: '麻醉麻醉麻醉麻醉麻醉麻醉麻醉'
  )
  @department9 = Department.create(
      id: 9,
      name: 'CT室',
      short_name: 'CT室',
      spell_code: 'CT',
      phone_number: '57976771',
      hospital_id: @hospital1.id,
      description: '武警总医院CT科医疗设备先进，技术力量雄厚，服务质量、检查技术及诊断水平在国内位居前列。科室现有2台目前国际上最先进的超高端CT机--美国GE公司的HD高清能谱CT扫描机和德国西门子公司的Flash炫速双源CT扫描机，1台中端机--美国GE公司的16排CT扫描机。'
  )
  @department11 = Department.create(
      id: 11,
      name: '手术科',
      short_name: '手术科',
      spell_code: 'SSK',
      phone_number: '57976773',
      hospital_id: @hospital1.id,
      description: '不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊不要改啊'
  )

end

#医生

def make_doctors

  Doctor.delete_all
  @doctor1 = Doctor.create(
      id: '113932081080001',
      hospital_id: @hospital1.id,
      department_id: @department1.id,
      name: '田学军',
      spell_code: 'TXJ',
      credential_type: '身份证',
      credential_type_number: '132326196601192101',
      gender: '男',
      birthday: '1966-1-19',
      birthplace: '河北省保定',
      address: '河北省保',
      nationality: '汉族',
      citizenship: '中国',
      province: '河北省',
      county: '保定市',
      photo: 'd69839189c3a457dab2a606dff3ff2bc.jpg',
      marriage: '已婚',
      mobile_phone: '13601085005',
      home_phone: '010-123569856',
      home_address: '北京是石景山路5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'tianxuejun@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '本科',
      expertise: '肿瘤消融',
      certificate_number: '1101113932081080004681',
      is_control:'true',
      introduction: '长期的临床工作中，积累了丰富的肿瘤放疗经验。特别是对乳腺癌、消化道恶性肿瘤、宫颈癌、恶性淋巴瘤等肿瘤的综合治疗以及体部肿瘤的精确放疗有较深的造诣。',
      dictionary_ids: '26,28'
  )

  @doctor2 = Doctor.create(
      id: '113932081080002',
      name: '林然',
      hospital_id:@hospital1.id,
      department_id:@department1.id,
      spell_code: 'SL',
      credential_type: '身份证',
      credential_type_number: '132326197501192102',
      gender: '男',
      birthday: '1975-01-19',
      birthplace: '',
      address: '',
      nationality: '',
      citizenship: '',
      province: '',
      county: '',
      photo: 'b017185e742c4f28ae682dbf31c82019.png',
      marriage: '',
      mobile_phone: '',
      home_phone: '',
      home_address: '',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: '',
      professional_title: '',
      position: '',
      hire_date: '',
      degree: '',
      expertise:"肿瘤消融",
      certificate_number:'20111210172454',
      introduction:'在长期的临床工作中，积累了丰富的肿瘤治疗经验，熟悉各种常见肿瘤的诊断、放疗和相关新技术，注重综合治疗以及精确放疗。',
      dictionary_ids: '26,28'

  )
  @doctor3 = Doctor.create(
      id: '113932081080003',
      hospital_id: @hospital1.id,
      department_id: @department8.id,
      name: '王肖泽',
      spell_code: '王肖泽',
      credential_type: '身份证',
      credential_type_number: '142222197905041203',
      gender: '男',
      birthday: '1979-5-4',
      birthplace: '山西',
      address: '山西',
      nationality: '汉族',
      citizenship: '中国',
      province: '山西',
      county: '山西某县',
      photo: 'd1641755b2d64f4e9337a6b804d9a154.jpg',
      marriage: '已婚',
      mobile_phone: '13910423691',
      home_phone: '010-123569856',
      home_address: '北京是石景山路5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'wangxiaoze@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '本科',
      expertise: '肿瘤消融',
      certificate_number: '20111210172454',
      is_control:'true',
      introduction: ' 从事放射肿瘤专业多年，具有丰富的临床工作经验，特别是胸腹部肿瘤的治疗。',
      dictionary_ids: '26,28'

  )
  @doctor4 = Doctor.create(
      id: '113932081080004',
      hospital_id: @hospital1.id,
      department_id: @department8.id,
      name: '李广森',
      spell_code: 'LGS',
      credential_type: '身份证',
      credential_type_number: '372501197005015604',
      gender: '男',
      birthday: '1970-05-01',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '1aae1364ade747b88dc2f559a1ddd6fa.jpg',
      marriage: '已婚',
      mobile_phone: '13671189612',
      home_phone: '010-123569856',
      home_address: '北京是石景山路5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'liguansen@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '本科',
      expertise: "肿瘤消融",
      certificate_number: '20111210172454',
      introduction: '专门从事肺癌的放射治疗和放化综合治疗的基础和临床研究工作。',
      dictionary_ids: '26,28'

  )

  @doctor5 = Doctor.create(
      id: '113932081080005',
      hospital_id: @hospital1.id,
      department_id: @department8.id,
      name: '林育松',
      spell_code: 'LYS',
      credential_type: '身份证',
      credential_type_number: '110108197209123705',
      gender: '男',
      birthday: '1972-09-12',
      birthplace: '北京',
      address: '北京',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京',
      county: '石景山',
      photo: '8d3b5227b11b4394abbaa34a90aaf91f.jpg',
      marriage: '已婚',
      mobile_phone: '15269856325',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'linyusong@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '本科',
      expertise: "肿瘤消融",
      certificate_number: '20111210172454',
      is_control:'true',
      introduction: '从事肿瘤专业近二十年，在恶性肿瘤的诊断与治疗方面具有丰富的临床经验，尤其擅长于肺癌的诊断与综合治疗（包括化疗、靶向药物治疗以及局部介入治疗等）。',
      dictionary_ids: '28'

  )

  @doctor6 = Doctor.create(
      id: '113932081080006',
      hospital_id: @hospital1.id,
      department_id: @department2.id,
      name: '吴中和',
      spell_code: 'WZH',
      credential_type: '身份证',
      credential_type_number: '110107194811051206',
      gender: '男',
      birthday: '1948-11-05',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '236a4e19e0f341909e2809b259b9b4de.jpg',
      marriage: '已婚',
      mobile_phone: '13326398562',
      home_phone: '',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'wuzhonghe@163.com',
      professional_title: '主任医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '肿瘤消融',
      certificate_number: '20111210172454',
      introduction: '长期的临床工作中，积累了丰富的肿瘤放疗经验。特别是对乳腺癌、消化道恶性肿瘤、宫颈癌、恶性淋巴瘤等肿瘤的综合治疗以及体部肿瘤的精确放疗有较深的造诣。',
      dictionary_ids: '26'
  )

  @doctor7 = Doctor.create(
      id: '113932081080007',
      hospital_id: @hospital1.id,
      department_id: @department2.id,
      name: '林美华',
      spell_code: 'LMH',
      credential_type: '身份证',
      credential_type_number: '132569196512133207',
      gender: '女',
      birthday: '1965-12-14',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '83504bc16d1844b8a83d5c7ac61c0d8d.jpg',
      marriage: '已婚',
      mobile_phone: '13322588562',
      home_phone: '',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'linmeihua@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '本科',
      expertise: '肿瘤消融',
      certificate_number: '20111210172454',
      introduction: '主要从事结核病、胸部肿瘤及呼吸系统疾病的临床、科研、教学和防治工作。',
      dictionary_ids: '26'
  )

  @doctor8 = Doctor.create(
      id: '113932081080008',
      hospital_id: @hospital1.id,
      department_id: @department8.id,
      name: '张军',
      spell_code: 'ZJ',
      credential_type: '身份证',
      credential_type_number: '120222195812110008',
      gender: '女',
      birthday: '1958-12-11',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '6582fe67922d4dad995e2b5c7ffa0bf4.jpg',
      marriage: '已婚',
      mobile_phone: '13322589652',
      home_phone: '',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'zhangjun@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '本科',
      expertise: "肿瘤消融",
      certificate_number: '20111210172454',
      introduction: '从事肿瘤专业近二十年，在恶性肿瘤的诊断与治疗方面具有丰富的临床经验，尤其擅长于肺癌的诊断与综合治疗（包括化疗、靶向药物治疗以及局部介入治疗等）。',
      dictionary_ids: '26'
  )

  @doctor9 = Doctor.create(
      id: '113932081080009',
      hospital_id: @hospital1.id,
      department_id: @department8.id,
      name: '卜云芸',
      spell_code: 'PYY',
      credential_type: '身份证',
      credential_type_number: '510802198405242009',
      gender: '女',
      birthday: '1984-05-24',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '4300031ff46d4bf39e055144b125fa09.jpg',
      marriage: '已婚',
      mobile_phone: '13322589745',
      home_phone: '',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'puyunyun@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '本科',
      expertise: "肿瘤消融",
      certificate_number: '20111210172454',
      is_control:'true',
      introduction: '专业特长为普胸外科，对肺癌的诊断治疗有全面的认识，擅长于肺癌、食管癌、纵隔肿瘤以及乳腺癌的诊断和治疗。',
      dictionary_ids: '26,27'
  )


  @doctor10 = Doctor.create(
      id: '113932081080010',
      hospital_id: @hospital1.id,
      department_id: @department8.id,
      name: '姚丙焱',
      spell_code: 'YBY',
      credential_type: '身份证',
      credential_type_number: '372501196903072010',
      gender: '男',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '0894c96552224993b5a2aaa93bd137ba.jpg',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'yaobingyan@163.com',
      professional_title: '主治医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: "肿瘤消融",
      certificate_number: '20111210172454',
      introduction: '长期的临床工作中，积累了丰富的肿瘤放疗经验。特别是对乳腺癌、消化道恶性肿瘤、宫颈癌、恶性淋巴瘤等肿瘤的综合治疗以及体部肿瘤的精确放疗有较深的造诣。',
      dictionary_ids: '26,28'

  )
  @doctor11 = Doctor.create(
      id: '113932081080011',
      hospital_id: @hospital1.id,
      department_id: @department9.id,
      name: '李春伶',
      spell_code: 'LCL',
      credential_type: '身份证',
      credential_type_number: '372501196903072011',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'lichunling@163.com',
      professional_title: '主任医师、教授',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '心脏、腹部、外周血管、妇产科、TCI、介入超声、腔内超声、小器官等疑难病、多发病的超声诊断技术、缺血性心脏病检查及心功能、动脉硬化、脉管炎、深静脉血栓、乳腺等疾病检查',
      certificate_number: '20111210172454',
      introduction: '李春伶，女，主任医师，教授，南楼特诊科主任，硕导，武警部队超声医学专业委员会副主任委员。经过系统的专业深造，具有扎实的专业知识和较强的科研、教学能力，熟练掌握心脏、腹部、外周血管、妇产科、TCI、介入超声、腔内超声、小器官等疑难病、多发病的超声诊断技术，尤其擅长缺血性心脏病检查及心功能评价，并对动脉硬化、脉管炎、深静脉血栓、乳腺等疾病检查积累了丰富经验。在国内外杂志上发表论文多篇，获得全军和武警部队科技进步奖多项',
      dictionary_ids: '27,28'

  )
  @doctor12 = Doctor.create(
      id: '113932081080012',
      hospital_id: @hospital1.id,
      department_id: @department9.id,
      name: '张宏',
      spell_code: 'ZH',
      credential_type: '身份证',
      credential_type_number: '372501196903072012',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13322589745',
      home_phone: '',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'zhanghong@163.com',
      professional_title: '主任医师、科主任',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '冠心病心肌缺血的诊断、评价胎儿宫内缺血缺氧及发育情况、介入型超声的诊断治疗',
      certificate_number: '20111210172454',
      introduction: '张宏，女，主任医师，科主任，现任全军超声专业委员，武警超声专业的主任委员。从事医疗超声影像专业30多年，精通心脏、腹部、妇产科、血管超声，腔内超声、介入超声等多种超声检查诊治工作。尤其擅长冠心病心肌缺血的诊断，评价胎儿宫内缺血缺氧及发育情况，并在介入型超声的诊断、治疗领域也颇有研究。曾获得全军科技进步二等奖和武警部队科技进步一等奖等10余项，在国内外杂志上发表论文50余篇，享受国务院政府特殊津贴，2003年获得全军特殊岗位津贴三等奖。',
      dictionary_ids: '27'

  )
  @doctor13 = Doctor.create(
      id: '113932081080013',
      hospital_id: @hospital1.id,
      department_id: @department9.id,
      name: '刘普清',
      spell_code: 'LPQ',
      credential_type: '身份证',
      credential_type_number: '372501196903072013',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'liupuqing@163.com',
      professional_title: '特聘高年资医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '妇科疾病、肝胆外科疾病的诊断、介入性超声诊断及治疗并对肝癌等腹部肿瘤的诊断及肿瘤介入治疗前后的疗效观察 ',
      certificate_number: '20111210172454',
      introduction: '刘晋清，女，特聘高年资医师，从事医疗超声影像专业工作30余年，对腹部、妇产科、小器官及血管、心脏等全身多系统疾病诊断均有丰富经验，并具有麻醉及手术室工作经验，技术全面。尤其对妇科疾病，肝胆外科疾病的诊断有优势，擅长介入性超声诊断及治疗，并对肝癌等腹部肿瘤的诊断及肿瘤介入治疗前后的疗效观察。疗效评估有较深入的研究',
      dictionary_ids: '26,27,28'

  )
  @doctor14 = Doctor.create(
      id: '113932081080014',
      hospital_id: @hospital1.id,
      department_id: @department1.id,
      name: '井茹芳',
      spell_code: 'JRF',
      credential_type: '身份证',
      credential_type_number: '372501196903072014',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '北京市石景山区',
      address: '北京市石景山区',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京市',
      county: '石景山区',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13322589745',
      home_phone: '',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'jingrufang@163.com',
      professional_title: '主任技师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '腹部超声的常见病、多发病、妇产科的常见病、多发病、疑难病的诊断',
      certificate_number: '20111210172454',
      introduction: '井茹芳，女，主任技师，从事超声专业工作二十年，熟练掌握超声诊断理论知识及操作技术，对腹部超声的常见病、多发病、疑难病能够做出正确的诊断，特别对妇产科的常见病、多发病、疑难病的诊断有独到之处。利用超声技术及时诊断脏器损伤有较丰富的经验，如肝、脾破裂，肾脏挫裂伤及包膜下出血，应用彩色多普勒技术进行各种疾病的诊断及鉴别诊断，如肝癌、肾癌、卵巢癌、子宫内膜癌等，宫外孕与炎性包块的鉴别，卵巢良、恶性囊肿的鉴别诊断等，为临床诊断提供准确依据',
      dictionary_ids: '26,27,28'

  )
  @doctor15 = Doctor.create(
      id: '113932081080015',
      hospital_id: @hospital1.id,
      department_id: @department1.id,
      name: '田蓉',
      spell_code: 'TR',
      credential_type: '身份证',
      credential_type_number: '372501196903072015',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'tianrong@163.com',
      professional_title: '副主任医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '心脏、腹部、妇产科、小器官及血管等全身多系统疾病诊断',
      certificate_number: '20111210172454',
      introduction: '"田蓉，副主任医师，从事超声影像专业工作17余年，有扎实的理论基础及丰富的临床经验。精通心脏、腹部、妇产科、小器官及血管等全身多系统疾病诊断均有丰富经验，技术全面。尤其对妇科疾病，血管及腹部疾病的诊断有优势，并对肝癌等腹部肿瘤的诊断及肿瘤介入治疗前后的疗效观察，疗效评估有较深入的研究。发表论文30余篇。"',
      dictionary_ids: '26,28'

  )
  @doctor16 = Doctor.create(
      id: '113932081080016',
      hospital_id: @hospital1.id,
      department_id: @department1.id,
      name: '寇海燕',
      spell_code: 'KHY',
      credential_type: '身份证',
      credential_type_number: '372501196903072016',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '山西',
      address: '山西',
      nationality: '汉族',
      citizenship: '中国',
      province: '山西',
      county: '山西某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13910423691',
      home_phone: '010-123569856',
      home_address: '北京是石景山路5号',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'kouhaiyan@163.com',
      professional_title: '副主任医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '腹部超声的常见病、多发病、疑难病',
      certificate_number: '20111210172454',
      introduction: '寇海燕女介入副主任诊治医师主任外科助理从事综合超声国际影像专业综合工作留学余年经过应用较医学系统的专业妇产培训熟练掌握超声诊断导师专业临床知识协和及操作技术对腹部超声的慢性常见病多发病出生疑难病能够做出正确的诊断上海有一定的人才实践工作经过经验工作和创新能力先后指导众多发表学术英国论文余篇.',
      dictionary_ids: '26'

  )
  @doctor17 = Doctor.create(
      id: '113932081080017',
      hospital_id: @hospital1.id,
      department_id: @department2.id,
      name: '高建华',
      spell_code: 'GJH',
      credential_type: '身份证',
      credential_type_number: '372501196905862017',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'gaojianhua@163.com',
      professional_title: 'CT科主任，主任医师',
      position: '',
      hire_date: '',
      degree: '硕士研究生',
      expertise: '具备扎实的专业理论基础、丰富的临床经验、出色的科研教学能力和组织策划才能，对多排螺旋CT诊断心脑血管病、小儿复杂先天性心脏病及CT低剂量技术有深入研究',
      certificate_number: '20111210172454',
      introduction: ' CT科主任，主任医师，硕士研究生学历。1985年毕业于中国人民解放军白求恩军医学院医疗系，1998年入第四军医大学（98）军队临床医学中青年人才培养基金班学习2年，2004年曾赴美国学习64排CT操作技术及临床应用技能。从事临床工作30余年，具备扎实的专业理论基础、丰富的临床经验、出色的科研教学能力和组织策划才能，对多排螺旋CT诊断心脑血管病、小儿复杂先天性心脏病及CT低剂量技术有深入研究并取得显著成果，为我院优秀学科带头人之一，研究成果曾获武警部队科技进步一等奖1项、二等奖3项。',
      dictionary_ids: '27,28'

  )
  @doctor18 = Doctor.create(
      id: '113932081080018',
      hospital_id: @hospital1.id,
      department_id: @department2.id,
      name: '戴汝平',
      spell_code: 'DRP',
      credential_type: '身份证',
      credential_type_number: '372501196903072018',
      gender: '男',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'dairuping@163.com',
      professional_title: '教授，CT客座专家、首席医疗顾问',
      position: '',
      hire_date: '',
      degree: '博士生导师',
      expertise: '冠状动脉内溶栓治疗急性心肌梗塞、先心病、瓣膜病、大动脉疾患等介入治疗',
      certificate_number: '20111210172454',
      introduction: '曾获中国工程院院士提名（中国医学科学院，卫生部）。从事心血管放射诊断及心血管介入治疗40余年。1982年率先在国内开展介入治疗新技术，包括冠状动脉内溶栓治疗急性心肌梗塞、先心病、瓣膜病、大动脉疾患等介入治疗； 1995年在国内率先开展"电子束CT心血管诊断研究"，开发了冠状动脉三维重建方法，实现了CT诊断心血管病的可能性，出版国内第一部"心血管病CT诊断学"专著，开拓了心血管病影像学新领域。',
      dictionary_ids: '26,28'

  )
  @doctor19 = Doctor.create(
      id: '113932081080019',
      hospital_id: @hospital1.id,
      department_id: @department3.id,
      name: '蔡祖龙',
      spell_code: 'CZL',
      credential_type: '身份证',
      credential_type_number: '372501196903072019',
      gender: '男',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'caizulong@163.com',
      professional_title: '主任医师',
      position: '',
      hire_date: '',
      degree: '博士生导师',
      expertise: '心胸影像诊断',
      certificate_number: '20111210172454',
      introduction: '教授，CT客座专家、首席医疗顾问。解放军总医院医学影像中心主任，博士生导师，1992年起享受政府特殊津贴，中央保健办特聘专家，国内著名医学影像学专家。在心胸影像诊断方面有较高造诣，主编多部影像诊断专著，曾获“解放军图书奖”，“中国图书奖”，“全国优秀科技图书奖”等。现担任中国医学影像技术研究会副会长，解放军医学科学技术委员会委员，全军放射诊疗学专业委员会副主任委员，北京放射学会委员，第五届、第六届中华医学会放射学分会常务委员，总后勤部高评委委员，《中华放射学杂志》等5种杂志常委编委。',
      dictionary_ids: '28'

  )

  @doctor20 = Doctor.create(
      id: '113932081080020',
      hospital_id: @hospital1.id,
      department_id: @department3.id,
      name: '齐连君',
      spell_code: 'QLJ',
      credential_type: '身份证',
      credential_type_number: '372501196903072020',
      gender: '男',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'qilianjun@163.com',
      professional_title: '副主任医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '影像诊断',
      certificate_number: '20111210172454',
      introduction: ' 放射科主任，副主任医师，武警放射专业委员会副主任委员。从事影像诊断工作二十余年。擅长介入放射诊断治疗、全身X线影像诊断和消化道造影诊断工作，尤其在介入治疗全身恶性肿瘤、肝血管瘤、子宫肌瘤、支气管动脉大咳血的栓塞治疗、肝移植病人术后的血管和胆管的介入处理及食道支架放置方面积累了较丰富的经验。',
      dictionary_ids: '28'

  )


  @doctor21 = Doctor.create(
      id: '113932081080021',
      hospital_id: @hospital1.id,
      department_id: @department11.id,
      name: '陈克林',
      spell_code: 'CKL',
      credential_type: '身份证',
      credential_type_number: '372501196903072021',
      gender: '男',
      birthday: '1969-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'chenkelin@163.com',
      professional_title: '主任医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '全身介入治疗、全身X线诊断和胃肠等特殊造影诊断工作',
      certificate_number: '20111210172454',
      introduction: ' 主任医师，原放射科主任。在军内外享有较高知名度的专家，曾担任武警放射专业委员会主任委员和全军放射专业委员会委员、武警医学编委等职务。擅长于全身介入治疗、全身X线诊断和胃肠等特殊造影诊断工作，特别在各种恶性肿瘤的X线诊断反介入治疗，骨关节疾病的X线诊断，儿童骨测量，身高预测方法有比较丰富的经验。',
      dictionary_ids: '28'

  )
  @doctor22 = Doctor.create(
      id: '113932081080022',
      hospital_id: @hospital1.id,
      department_id: @department11.id,
      name: '曾熔',
      spell_code: 'ZR',
      credential_type: '身份证',
      credential_type_number: '372501196903072022',
      gender: '男',
      birthday: '1969-03-07',
      birthplace: '河北',
      address: '河北',
      nationality: '汉族',
      citizenship: '中国',
      province: '河北',
      county: '河北某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'chenkelin@163.com',
      professional_title: ' 副主任医师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '全身介入放射诊断治疗、胃肠造影及放射诊断',
      certificate_number: '20111210172454',
      introduction: '  副主任医师。毕业于华西医科大学，擅长全身介入放射诊断治疗、胃肠造影及放射诊断。熟练掌握头颈部、腹部、盆腔、四肢血管疾病和肿瘤的介入诊治方法，尤其在肝移植病人的介入诊治、肝癌的肝段、亚肝段栓塞以及肝移植术后胆管并发症的介入治疗方面取得了丰富的临床经验、疗效和独特的创新见解。',
      dictionary_ids: '26,28'

  )
  @doctor23 = Doctor.create(
      id: '113932081080023',
      hospital_id: @hospital1.id,
      department_id: @department11.id,
      name: '王海燕',
      spell_code: 'WHY',
      credential_type: '身份证',
      credential_type_number: '372501196903072023',
      gender: '女',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'wanghaiyan@163.com',
      professional_title: '主任技师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '长临床微生物学，临床免疫学及分子生物学',
      certificate_number: '20111210172454',
      introduction: ' 主任技师，1952年出生。本科学历，从事临床检验工作39年，现任全军标准物质委员会副主任委员，全军检验专业委员会常务委员，解放军检验医学杂志常务编委，武警部队检验专业委员会主任委员，武警部队艾滋病确认实验室主任，曾获武警部队科技进步二等奖一项，三等奖五项，专业特长临床微生物学，临床免疫学及分子生物学。',
      dictionary_ids: '26,28'

  )
  @doctor24 = Doctor.create(
      id: '113932081080024',
      hospital_id: @hospital1.id,
      department_id: @department11.id,
      name: '王秀梅',
      spell_code: 'WXM',
      credential_type: '身份证',
      credential_type_number: '372501196903072024',
      gender: '女',
      birthday: '1969-03-07',
      birthplace: '河北',
      address: '河北',
      nationality: '汉族',
      citizenship: '中国',
      province: '河北',
      county: '河北某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'chenkelin@163.com',
      professional_title: ' 副主任',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '甲状腺功能的测定；胰岛功能的测定；女性更年期内分泌紊乱性激素的测定；早孕、宫外孕及葡萄胎的鉴别诊断项目的测定等临床意义',
      certificate_number: '20111210172454',
      introduction: '  检验科副主任。从事本专业30年，积累了丰富的工作及带教经验。对放免科所开展的各项检测项目均能熟练掌握，并能解决专业技术上的疑难问题。熟练掌握本科各种仪器设备的操作、维修、保养等。对其所检测项目如：甲状腺功能的测定；胰岛功能的测定；女性更年期内分泌紊乱性激素的测定；早孕、宫外孕及葡萄胎的鉴别诊断项目的测定等临床意义均能熟练掌握，检测结果准确率均达95％以上。发表论文30余篇。荣立三等功一次。',
      dictionary_ids: '26,27'

  )
  @doctor25 = Doctor.create(
      id: '113932081080025',
      hospital_id: @hospital1.id,
      department_id: @department8.id,
      name: '郝钦芳',
      spell_code: 'HQF',
      credential_type: '身份证',
      credential_type_number: '372501196903072025',
      gender: '男',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'wanghaiyan@163.com',
      professional_title: '副主任技师',
      position: '',
      hire_date: '',
      degree: '博士',
      expertise: '擅长生化学、临检学检验',
      certificate_number: '20111210172454',
      introduction: ' 副主任技师。主任助理，经过系统的专业培训，具有较扎实的专业知识和较丰富的临床检验经验。擅长生化学、临检学检验。发表文章10余篇，获科技进步二等奖1项，科技进步三等奖2项，科技进步四等奖1项。',
      dictionary_ids: '26,27'

  )
  @doctor26 = Doctor.create(
      id: '113932081080026',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '董宝玮',
      spell_code: 'DBW',
      credential_type: '身份证',
      credential_type_number: '372501196903072026',
      gender: '男',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'dongbaowei@163.com',
      professional_title: '主任医师',
      position: '教授',
      hire_date: '',
      degree: '博士生导师',
      expertise: '腹部超声诊断，超声引导介入诊断与治疗，微波治疗肝癌',
      certificate_number: '20111210172454',
      introduction: '博士和博士后导师，1967年毕业于中国协和医科大学，1984年赴加拿大麦吉尔大学医学院学习，1985年赴丹麦哥本哈根大学医院进修；1986年至1992年任北京医科大学肿瘤研究所超声科主任；1992年至2004年任解放军总医院超声科主任。曾任中华医学杂志编委，国家自然科学基金评委，中华医学会北京市超声学会主任委员，解放军超声医学专业委员会副主任委员，中华超声影像学杂志副总编，第九届和第十届北京市政协委员。',
      dictionary_ids: '26,27,28'
  )
  @doctor27 = Doctor.create(
      id: '113932081080027',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '梁萍',
      spell_code: 'LP',
      credential_type: '身份证',
      credential_type_number: '372501196903072027',
      gender: '女',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市海淀区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'liangping@163.com',
      professional_title: '主任医师',
      position: '介入超声科主任',
      hire_date: '',
      degree: '博士生导师',
      expertise: '腹部疑难疾病的超声诊断；多脏器实体肿瘤（肝、肾、肾上腺、甲状腺等）的微波、射频热消融治疗；热消融后免疫治疗；多模态影像手术导航微创治疗',
      certificate_number: '20111210172454',
      introduction: ' 医学博士，现任解放军总医院介入超声科主任，主任医师、教授，博士生导师。长期从事介入超声诊断与治疗工作。带领团队研发了我国首台水冷温控植入式微波热消融系统并通过药监局验证在临床正式使用，现已推广应用于150多家医院治疗患者约3万名。在国内外率先开展了微波消融治疗肝脏、肾脏和肾上腺肿瘤等多脏器实体肿瘤的基础与临床研究，为大量不能手术的实体肿瘤患者开辟了一条安全、微创、疗效确实的希望之路。近五年又开展了机器人导航数字化影像技术在介入超声中的应用研究。',
      dictionary_ids: '27,28'

  )
  @doctor28 = Doctor.create(
      id: '113932081080028',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '于晓玲',
      spell_code: 'YXL',
      credential_type: '身份证',
      credential_type_number: '372501196903072028',
      gender: '女',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'yuxiaoling@163.com',
      professional_title: '主任医师',
      position: '介入超声科副主任',
      hire_date: '',
      degree: '博士生导师',
      expertise: '腹部及胸部肿瘤的彩超及超声造影诊断；介入性超声诊断与治疗，多脏器实体肿瘤（如肝、肾、肾上腺、脾、肺、甲状腺、胰腺等部位肿瘤）的超声引导下局部治疗（微波治疗、射频治疗、酒精治疗、粒子植入局部放疗等），以及联合免疫治疗、联合栓塞、联合药物治疗',
      certificate_number: '20111210172454',
      introduction: ' 医学博士， 博士研究生导师， 1984年毕业于第四军医大学医疗系，现任解放军总医院介入超声科副主任，曾留学丹麦（1997年丹麦哥本哈根大学附属Herlev医学院国际介入超声中心），师从国际介入性超声创始人、国际介入性超声学会主席H.H.Holm教授，2000年香港中文大学威尔士亲王医院放射科访问学者，并在上述两单位开展微波消融治疗肝癌的临床合作研究。长期从事腹部超声及介入性超声诊断与治疗工作及研究。',
      dictionary_ids: '27'

  )
  @doctor29 = Doctor.create(
      id: '113932081080029',
      hospital_id: @hospital1.id,
      department_id: @department11.id,
      name: '马林',
      spell_code: 'ML',
      credential_type: '身份证',
      credential_type_number: '372501196903072029',
      gender: '男',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市海淀区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'malin@163.com',
      professional_title: '主任医师',
      position: '放疗科主任',
      hire_date: '',
      degree: '博士生导师',
      expertise: '主要特长为恶性肿瘤临床综合治疗方案的制定、肿瘤精确放疗（三维适形放疗，调强放疗）,特别是在乳腺癌临床治疗及基础研究方面有较深的造诣',
      certificate_number: '20111210172454',
      introduction: ' 解放军总医院放疗科主任，主任医师，教授，博士研究生导师,全军放射肿瘤专业委员会副主任委员, 中华放射肿瘤学专业委员会常委，中华医学会北京市分会放射肿瘤专业委员会委员，中华放射肿瘤学杂志》常务编委。
1990年至2000年在法国从事肿瘤放疗临床工作及基础研究,先后获得法国巴黎第5大学肿瘤放射治疗临床博士学位及巴黎第7大学肿瘤发生基础博士学位，主要特长为恶性肿瘤临床综合治疗方案的制定、肿瘤精确放疗（三维适形放疗，调强放疗）,特别是在乳腺癌临床治疗及基础研究方面有较深的造诣。',
      dictionary_ids: '26,28'

  )
  @doctor30 = Doctor.create(
      id: '113932081080030',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '周桂霞',
      spell_code: 'ZGX',
      credential_type: '身份证',
      credential_type_number: '372501196903072030',
      gender: '女',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市海淀区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'zhouguixia@163.com',
      professional_title: '副主任医师',
      position: '放疗科副主任',
      hire_date: '',
      degree: '硕士研究生导师',
      expertise: '擅长各种肿瘤的常规放射治疗、立体定向放射治疗、三维适形照射和影像引导下的精确放射治疗,有26年临床经验',
      certificate_number: '20111210172454',
      introduction: ' 解放军总医院放疗科副主任。擅长各种肿瘤的常规放射治疗、立体定向放射治疗、三维适形照射和影像引导下的精确放射治疗,有26年临床经验。
率先在我院开展了多部位肿瘤的微型放射源的后装近距离治疗（腔内、组织间插值和贴敷放疗）；参与国内三维适形放疗的临床研发工作，并率先在我院开展了体部肿瘤的立体定向放疗和三维适形照射,特别对肝癌、胰腺癌、胆管癌和宫颈癌的治疗有深入研究。',
      dictionary_ids: '26,28'

  )
  @doctor31 = Doctor.create(
      id: '113932081080031',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '冯林春',
      spell_code: 'FLC',
      credential_type: '身份证',
      credential_type_number: '372501196903072031',
      gender: '男',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市石景山区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'fenglingchun@163.com',
      professional_title: '副主任医师',
      position: '放疗科副主任',
      hire_date: '',
      degree: '硕士研究生导师',
      expertise: '肿瘤精确放疗(包括立体定向三维适形放疗、调强放疗及螺旋断层放疗)。（2）肿瘤术前放疗、术中放疗及术后放疗。',
      certificate_number: '20111210172454',
      introduction: ' 解放军总医院放疗科副主任。自1987年以来一直从事肿瘤放射治疗的临床工作及相关基础研究工作。在常见恶性肿瘤的放射治疗方面积累了丰富的临床实践经验。对利用精确放疗手段(立体定向三维适形放疗及调强放疗)治疗胸部肿瘤，尤其是难治性恶性肿瘤(如恶性黑色素瘤、软组织肉瘤等)以及一些良性肿瘤(如血管瘤、胰瘘、疤痕疙瘩等)的综合治疗有独到的见解。
参加多项科研工作,其中《核医学和放射治疗中先进技术的研究》为国家重点科研课题攀登计划B项目。',
      dictionary_ids: '26,28'

  )
  @doctor32 = Doctor.create(
      id: '113932081080032',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '焦顺昌',
      spell_code: 'JSC',
      credential_type: '身份证',
      credential_type_number: '372501196903072032',
      gender: '男',
      birthday: '1952-03-07',
      birthplace: '北京',
      address: '北京',
      nationality: '汉族',
      citizenship: '中国',
      province: '北京',
      county: '海淀',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市海淀区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'jiaoshunchang@163.com',
      professional_title: '主任医师',
      position: '担任社会学术职务',
      hire_date: '',
      degree: '博士',
      expertise: '1、肿瘤的综合治疗；2、化疗增敏的研究；3、以免疫、基因治疗为主的肿瘤生物靶向治疗',
      certificate_number: '20111210172454',
      introduction: ' 担任社会学术职务：目前任解放军总医院肿瘤内科主任、教授、解放军总医院军医进修学院医学科学技术委员会委员、全军医学科学技术委员会肿瘤学专业委员会委员、中国抗癌协会临床肿瘤学协作中心（CSCO）执行委员会委员、中国生物医学工程学会肿瘤生物靶向治疗专业组负责人、北京市抗癌协会理事、中华医学会北京肿瘤分会委员、美国临床肿瘤学会（ASCO）会员等职；并任军医进修学院学报、中国药物应用与监测、英国医学杂志（BMJ中文版）、解放军保健医学杂志等杂志编委。',
      dictionary_ids: '26,28'

  )
  @doctor33 = Doctor.create(
      id: '113932081080033',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '杨俊兰',
      spell_code: 'YJL',
      credential_type: '身份证',
      credential_type_number: '372501196903072033',
      gender: '女',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市海淀区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'yangjunlan@163.com',
      professional_title: '主任医师',
      position: '担任社会学术职务',
      hire_date: '',
      degree: '硕士',
      expertise: '1、肿瘤的综合治疗；2、化疗增敏的研究。',
      certificate_number: '20111210172454',
      introduction: ' 担任社会学术职务：
近5年出版论著和发表学术论文：《功能性胃肠病学》等论著2部，《NP方案治疗复治的晚期转移性乳腺癌的临床观察》《非小细胞肺癌MDR1-mRNA、MRP-mRNA及LRP-mRNA表达的研究》《常规化疗致Ⅳ度骨髓抑制的处理》等10多篇。',
      dictionary_ids: '26,27,28'

  )
  @doctor34 = Doctor.create(
      id: '113932081080034',
      hospital_id: @hospital1.id,
      department_id: @department4.id,
      name: '李方',
      spell_code: 'LF',
      credential_type: '身份证',
      credential_type_number: '372501196903072034',
      gender: '女',
      birthday: '1952-03-07',
      birthplace: '山东',
      address: '山东',
      nationality: '汉族',
      citizenship: '中国',
      province: '山东',
      county: '山东某县',
      photo: '',
      marriage: '已婚',
      mobile_phone: '13366919414',
      home_phone: '010-123569856',
      home_address: '北京市海淀区',
      contact: '',
      contact_phone: '',
      home_postcode: '',
      email: 'lifang@163.com',
      professional_title: '副主任医师',
      position: '',
      hire_date: '',
      degree: '学士学位',
      expertise: '以化疗为主的综合治疗；腹腔化疗；生物治疗',
      certificate_number: '20111210172454',
      introduction: ' 担任社会学术职务:
近5年出版论著和发表学术论文：10多篇。',
      dictionary_ids: '26,27,28'

  )
end


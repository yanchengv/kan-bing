#encoding:utf-8
namespace :db  do
  task seed:  :environment do
    make_dictionary
  end
end
def make_dictionary
  Dictionary.delete_all
  DictionaryType.delete_all
  DictionaryType.create(
      id: 1,
      name: '用户级别',
      code: 'user_level',
      description: ''
  )
  Dictionary.create( #1
      id: 1,
      name: '钻石用户',
      code: '',
      description: '',
      dictionary_type_id: 1
  )
  Dictionary.create( #2
      id: 2,
      name: '金卡用户',
      code: '',
      description: '',
      dictionary_type_id: 1
  )
  Dictionary.create( #3
      id: 3,
      name: '银卡用户',
      code: '',
      description: '',
      dictionary_type_id: 1
  )
  DictionaryType.create(
      id: 2,
      name: '新闻类型',
      code: 'dictionary_id',
      description: ''
  )
  Dictionary.create(#4
      id: 4,
      name: '新闻中心',
      code: 'news_center',
      description: '',
      dictionary_type_id: 2
  )
  Dictionary.create(#5
      id: 5,
      name: '科室动态',
      code: 'department_dynamic',
      description: '',
      dictionary_type_id: 2
  )
  Dictionary.create( #6
      id: 6,
      name: '案例综述',
      code: 'case_summary',
      description: '',
      dictionary_type_id: 2
  )
  DictionaryType.create(
      id: 3,
      name: '健康卡类型',
      code: 'card_type',
      description: ''
  )
  Dictionary.create(  #7
      id: 7,
      name: '钻石卡',
      code: '',
      description: '',
      dictionary_type_id: 3
  )
  Dictionary.create(   #8
      id: 8,
      name: '金卡',
      code: '',
      description: '',
      dictionary_type_id: 3
  )
  Dictionary.create(   #9
      id: 9,
      name: '银卡',
      code: '',
      description: '',
      dictionary_type_id: 3
  )
  DictionaryType.create(
      id: 4,
      name: '医生职称',
      code: 'doctor_title',
      description: ''
  )
  Dictionary.create(  #10
      id: 10,
      name: '主治医师',
      code: '',
      description: '',
      dictionary_type_id: 4
  )
  Dictionary.create(  #11
      id: 11,
      name: '主任医师',
      code: '',
      description: '',
      dictionary_type_id: 4
  )
  Dictionary.create(   #12
      id: 12,
      name: '副主任医师',
      code: '',
      description: '',
      dictionary_type_id: 4
  )
  Dictionary.create(    #13
      id: 13,
      name: '医师',
      code: '',
      description: '',
      dictionary_type_id: 4
  )
  Dictionary.create(   #14
      id: 14,
      name: '医士',
      code: '',
      description: '',
      dictionary_type_id: 4
  )
  DictionaryType.create(
      id: 5,
      name: '医院等级',
      code: 'hospital_level',
      description: ''
  )
  Dictionary.create(   #15
      id: 15,
      name: '三级特等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(   #16
      id: 16,
      name: '三级甲等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(  #17
      id: 17,
      name: '三级乙等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(  #18
      id: 18,
      name: '三级丙等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(  #19
      id: 19,
      name: '二级甲等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(   #20
      id: 20,
      name: '二级乙等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(    #21
      id: 21,
      name: '二级丙等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(    #22
      id: 22,
      name: '一级甲等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(    #23
      id: 23,
      name: '一级乙等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  Dictionary.create(     #24
      id: 24,
      name: '一级丙等',
      code: '',
      description: '',
      dictionary_type_id: 5
  )
  DictionaryType.create(
      id: 6,
      name: '医疗服务类型',
      code: 'service_type',
      description: ''
  )
  Dictionary.create(    #25
      id: 25,
      name: '健康卡',
      code: '',
      description: '',
      dictionary_type_id: 6
  )
  DictionaryType.create(
      id: 7,
      name: '预约类型',
      code: 'appointment_type',
      description: ''
  )
  Dictionary.create(      #26
      id: 26,
      name: '超声检查',
      code: '',
      description: '',
      dictionary_type_id: 7
  )

  Dictionary.create(     #27
      id: 27,
      name: '婴儿四维彩超',
      code: '',
      description: '',
      dictionary_type_id: 7
  )
  Dictionary.create(     #28
      id: 28,
      name: '肿瘤CT检查',
      code: '',
      description: '',
      dictionary_type_id: 7
  )
  Dictionary.create(     #29
      id: 29,
      name: '宝宝照相',
      code: '',
      description: '',
      dictionary_type_id: 7
  )

end
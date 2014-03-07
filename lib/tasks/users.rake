#encoding:utf-8
namespace :db do
  task seed: :environment do
    users_data
  end
end

def users_data
  User.delete_all
  @user1 = User.create(
      id: 113933171401,
      name: 'admin',
      password: 'tsinghuamit',
      password_confirmation: 'tsinghuamit',
      patient_id: '',
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:'' ,level:1
  )
  @user2 = User.create(
      id: @doctor1.id,
      name: '田学军',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor1.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name   ,level:4
  )
  User.create(
      id: @doctor2.id,
      name: '林然',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor2.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor5.id,
      name: '林育松',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor5.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  @user3 = User.create(
      id: @doctor6.id,
      name: '吴中和',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor6.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  @user4 = User.create(
      id: @doctor4.id,
      name: '李广森',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor4.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
  User.create(
      id: @doctor7.id,
      name: '林美华',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor7.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  @user5= User.create(
      id: @patient1.id,
      name: '张三丰',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient1.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name ,level:''
  )
  @user6 = User.create(
      id: @doctor19.id,
      name: '蔡祖龙',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor19.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
  @user7 = User.create(
      id: @patient2.id,
      name: '张无忌',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient2.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:''
  )
  @user8 = User.create(
      id: @patient3.id,
      name: '因素素',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient3.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:''
  )
  @user9 = User.create(
      id: @patient4.id,
      name: '高元',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient4.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name   ,level:''
  )
  @user10 = User.create(
      id: @patient5.id,
      name: '罗卿平',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient5.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name   ,level:''
  )
  @user11 = User.create(
      id: @patient6.id,
      name: '马志武',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient6.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  @user12 = User.create(
      id: @doctor3.id,
      name: '王肖泽',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor3.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
  @user13 = User.create(
      id: @doctor8.id,
      name: '张军',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor8.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
  User.create(
      id: @doctor9.id,
      name: '卜云芸',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor9.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor10.id,
      name: '姚丙焱',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor10.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor11.id,
      name: '李春伶',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor11.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor12.id,
      name: '张宏',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor12.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor13.id,
      name: '刘普清',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor13.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor14.id,
      name: '井茹芳',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor14.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor15.id,
      name: '田蓉',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor15.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor16.id,
      name: '寇海燕',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor16.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor17.id,
      name: '高建华',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor17.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor18.id,
      name: '戴汝平',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor18.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor20.id,
      name: '齐连君',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor20.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor21.id,
      name: '陈克林',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor21.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor22.id,
      name: '曾　熔',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor22.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor23.id,
      name: '王海燕',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor23.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor24.id,
      name: '王秀梅',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor24.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor25.id,
      name: '郝钦芳',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor25.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor26.id,
      name: '董宝玮',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor26.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor27.id,
      name: '梁萍',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor27.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor28.id,
      name: '于晓玲',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor28.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor29.id,
      name: '马林',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor29.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor30.id,
      name: '曾　熔',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor30.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor31.id,
      name: '冯林春',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor31.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor32.id,
      name: '焦顺昌',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor32.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor33.id,
      name: '杨俊兰',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor33.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor34.id,
      name: '李方',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor34.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )

  User.create(
      id: @patient7.id,
      name: '郭晋',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient7.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient8.id,
      name: '张重阳',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient8.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient9.id,
      name: '黎少平',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient9.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient10.id,
      name: '程亚和',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient10.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient11.id,
      name: '张轩一',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient11.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient12.id,
      name: '张林',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient12.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient13.id,
      name: '任晨珲',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient13.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient14.id,
      name: '汪育彤',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient14.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient15.id,
      name: '周大',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient15.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient16.id,
      name: '李卓哲',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient16.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient17.id,
      name: '郭风',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient17.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient18.id,
      name: '李武宪',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient18.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient19.id,
      name: '汪才顺',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient19.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient20.id,
      name: '李长财',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient20.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient21.id,
      name: '李泰福',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient21.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient22.id,
      name: '李建利',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient22.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient23.id,
      name: '李泉凤',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient23.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient24.id,
      name: '于鹏丽',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient24.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient25.id,
      name: '周要为',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient25.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient26.id,
      name: '冯兴国',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient26.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient27.id,
      name: '马建国',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient27.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient28.id,
      name: '吕显祖',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient28.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient29.id,
      name: '程孝先',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient29.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient30.id,
      name: '甘铁生',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient30.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient31.id,
      name: '高大山',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient31.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient32.id,
      name: '谢大海',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient32.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient33.id,
      name: '马宏宇',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient33.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient34.id,
      name: '章汉夫',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient34.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient35.id,
      name: '周量',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient35.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient36.id,
      name: '李佳音',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient36.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient37.id,
      name: '张产',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient37.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient38.id,
      name: '李明昌',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient38.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient39.id,
      name: '张吉平',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient39.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient40.id,
      name: '张传君',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient40.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient41.id,
      name: '张立珍',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient41.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient42.id,
      name: '李凤鸣',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient42.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient43.id,
      name: '李成果',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient43.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient44.id,
      name: '李晓波',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient44.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient45.id,
      name: '李福安',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient45.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient46.id,
      name: '黄兴',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient46.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient47.id,
      name: '石泰',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient47.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient48.id,
      name: '石玉昆',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient48.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient49.id,
      name: '史佩平',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient49.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  User.create(
      id: @patient50.id,
      name: '邱启华',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: @patient50.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
end

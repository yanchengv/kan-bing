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
      mobile_phone:@doctor1.mobile_phone,
      email:@doctor1.email,
      credential_type_number:@doctor1.credential_type_number,
      remember_token: '',created_by:@user1.name   ,level:4
  )
  User.create(
      id: @doctor2.id,
      name: '盛林',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor2.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      mobile_phone:@doctor2.mobile_phone,
      email:@doctor2.email,
      credential_type_number:@doctor2.credential_type_number,
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
      mobile_phone:@doctor5.mobile_phone,
      email:@doctor5.email,
      credential_type_number:@doctor5.credential_type_number,
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
      mobile_phone:@doctor6.mobile_phone,
      email:@doctor6.email,
      credential_type_number:@doctor6.credential_type_number,
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
      mobile_phone:@doctor4.mobile_phone,
      email:@doctor4.email,
      credential_type_number:@doctor4.credential_type_number,
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
      mobile_phone:@doctor7.mobile_phone,
      email:@doctor7.email,
      credential_type_number:@doctor7.credential_type_number,
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
      mobile_phone:@patient1.mobile_phone,
      email:@patient1.email,
      credential_type_number:@patient1.credential_type_number,
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
      mobile_phone:@doctor19.mobile_phone,
      email:@doctor19.email,
      credential_type_number:@doctor19.credential_type_number,
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
      mobile_phone:@patient2.mobile_phone,
      email:@patient2.email,
      credential_type_number:@patient2.credential_type_number,
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
      mobile_phone:@patient3.mobile_phone,
      email:@patient3.email,
      credential_type_number:@patient3.credential_type_number,
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
      mobile_phone:@patient4.mobile_phone,
      email:@patient4.email,
      credential_type_number:@patient4.credential_type_number,
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
      mobile_phone:@patient5.mobile_phone,
      email:@patient5.email,
      credential_type_number:@patient5.credential_type_number,
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
      mobile_phone:@patient6.mobile_phone,
      email:@patient6.email,
      credential_type_number:@patient6.credential_type_number,
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
      mobile_phone:@doctor3.mobile_phone,
      email:@doctor3.email,
      credential_type_number:@doctor3.credential_type_number,
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
      mobile_phone:@doctor8.mobile_phone,
      email:@doctor8.email,
      credential_type_number:@doctor8.credential_type_number,
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
      mobile_phone:@doctor9.mobile_phone,
      email:@doctor9.email,
      credential_type_number:@doctor9.credential_type_number,
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
      mobile_phone:@doctor10.mobile_phone,
      email:@doctor10.email,
      credential_type_number:@doctor10.credential_type_number,
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
      mobile_phone:@doctor11.mobile_phone,
      email:@doctor11.email,
      credential_type_number:@doctor11.credential_type_number,
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
      mobile_phone:@doctor12.mobile_phone,
      email:@doctor12.email,
      credential_type_number:@doctor12.credential_type_number,
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
      mobile_phone:@doctor13.mobile_phone,
      email:@doctor13.email,
      credential_type_number:@doctor13.credential_type_number,
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
      mobile_phone:@doctor14.mobile_phone,
      email:@doctor14.email,
      credential_type_number:@doctor14.credential_type_number,
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
      mobile_phone:@doctor15.mobile_phone,
      email:@doctor15.email,
      credential_type_number:@doctor15.credential_type_number,
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
      mobile_phone:@doctor16.mobile_phone,
      email:@doctor16.email,
      credential_type_number:@doctor16.credential_type_number,
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
      mobile_phone:@doctor17.mobile_phone,
      email:@doctor17.email,
      credential_type_number:@doctor17.credential_type_number,
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
      mobile_phone:@doctor18.mobile_phone,
      email:@doctor18.email,
      credential_type_number:@doctor18.credential_type_number,
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
      mobile_phone:@doctor20.mobile_phone,
      email:@doctor20.email,
      credential_type_number:@doctor20.credential_type_number,
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
      mobile_phone:@doctor21.mobile_phone,
      email:@doctor21.email,
      credential_type_number:@doctor21.credential_type_number,
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
      mobile_phone:@doctor22.mobile_phone,
      email:@doctor22.email,
      credential_type_number:@doctor22.credential_type_number,
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
      mobile_phone:@doctor23.mobile_phone,
      email:@doctor23.email,
      credential_type_number:@doctor23.credential_type_number,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  User.create(
      id: @doctor24.id,
      name: '曾秀梅',
      password: 'mimas',
      password_confirmation: 'mimas',
      patient_id: '',
      doctor_id: @doctor24.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      mobile_phone:@doctor24.mobile_phone,
      email:@doctor24.email,
      credential_type_number:@doctor24.credential_type_number,
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
      mobile_phone:@doctor25.mobile_phone,
      email:@doctor25.email,
      credential_type_number:@doctor25.credential_type_number,
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
      mobile_phone:@doctor26.mobile_phone,
      email:@doctor26.email,
      credential_type_number:@doctor25.credential_type_number,
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
      mobile_phone:@doctor27.mobile_phone,
      email:@doctor27.email,
      credential_type_number:@doctor27.credential_type_number,
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
      mobile_phone:@doctor28.mobile_phone,
      email:@doctor28.email,
      credential_type_number:@doctor28.credential_type_number,
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
      mobile_phone:@doctor29.mobile_phone,
      email:@doctor29.email,
      credential_type_number:@doctor29.credential_type_number,
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
      mobile_phone:@doctor30.mobile_phone,
      email:@doctor30.email,
      credential_type_number:@doctor30.credential_type_number,
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
      mobile_phone:@doctor31.mobile_phone,
      email:@doctor31.email,
      credential_type_number:@doctor31.credential_type_number,
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
      mobile_phone:@doctor32.mobile_phone,
      email:@doctor32.email,
      credential_type_number:@doctor32.credential_type_number,
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
      mobile_phone:@doctor33.mobile_phone,
      email:@doctor33.email,
      credential_type_number:@doctor33.credential_type_number,
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
      mobile_phone:@doctor34.mobile_phone,
      email:@doctor34.email,
      credential_type_number:@doctor34.credential_type_number,
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
      mobile_phone:@patient7.mobile_phone,
      email:@patient7.email,
      credential_type_number:@patient7.credential_type_number,
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
      mobile_phone:@patient8.mobile_phone,
      email:@patient8.email,
      credential_type_number:@patient8.credential_type_number,
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
      mobile_phone:@patient9.mobile_phone,
      email:@patient9.email,
      credential_type_number:@patient9.credential_type_number,
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
      mobile_phone:@patient10.mobile_phone,
      email:@patient10.email,
      credential_type_number:@patient10.credential_type_number,
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
      mobile_phone:@patient11.mobile_phone,
      email:@patient11.email,
      credential_type_number:@patient11.credential_type_number,
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
      mobile_phone:@patient12.mobile_phone,
      email:@patient12.email,
      credential_type_number:@patient12.credential_type_number,
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
      mobile_phone:@patient13.mobile_phone,
      email:@patient13.email,
      credential_type_number:@patient13.credential_type_number,
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
      mobile_phone:@patient14.mobile_phone,
      email:@patient14.email,
      credential_type_number:@patient14.credential_type_number,
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
      mobile_phone:@patient15.mobile_phone,
      email:@patient15.email,
      credential_type_number:@patient15.credential_type_number,
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
      mobile_phone:@patient16.mobile_phone,
      email:@patient16.email,
      credential_type_number:@patient16.credential_type_number,
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
      mobile_phone:@patient17.mobile_phone,
      email:@patient17.email,
      credential_type_number:@patient17.credential_type_number,
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
      mobile_phone:@patient18.mobile_phone,
      email:@patient18.email,
      credential_type_number:@patient18.credential_type_number,
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
      mobile_phone:@patient19.mobile_phone,
      email:@patient19.email,
      credential_type_number:@patient19.credential_type_number,
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
      mobile_phone:@patient20.mobile_phone,
      email:@patient20.email,
      credential_type_number:@patient20.credential_type_number,
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
      mobile_phone:@patient21.mobile_phone,
      email:@patient21.email,
      credential_type_number:@patient21.credential_type_number,
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
      mobile_phone:@patient22.mobile_phone,
      email:@patient22.email,
      credential_type_number:@patient22.credential_type_number,
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
      mobile_phone:@patient23.mobile_phone,
      email:@patient23.email,
      credential_type_number:@patient23.credential_type_number,
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
      mobile_phone:@patient24.mobile_phone,
      email:@patient24.email,
      credential_type_number:@patient24.credential_type_number,
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
      mobile_phone:@patient25.mobile_phone,
      email:@patient25.email,
      credential_type_number:@patient25.credential_type_number,
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
      mobile_phone:@patient26.mobile_phone,
      email:@patient26.email,
      credential_type_number:@patient26.credential_type_number,
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
      mobile_phone:@patient27.mobile_phone,
      email:@patient27.email,
      credential_type_number:@patient27.credential_type_number,
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
      mobile_phone:@patient28.mobile_phone,
      email:@patient28.email,
      credential_type_number:@patient28.credential_type_number,
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
      mobile_phone:@patient29.mobile_phone,
      email:@patient29.email,
      credential_type_number:@patient29.credential_type_number,
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
      mobile_phone:@patient30.mobile_phone,
      email:@patient30.email,
      credential_type_number:@patient30.credential_type_number,
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
      mobile_phone:@patient31.mobile_phone,
      email:@patient31.email,
      credential_type_number:@patient31.credential_type_number,
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
      mobile_phone:@patient32.mobile_phone,
      email:@patient32.email,
      credential_type_number:@patient32.credential_type_number,
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
      mobile_phone:@patient33.mobile_phone,
      email:@patient33.email,
      credential_type_number:@patient33.credential_type_number,
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
      mobile_phone:@patient34.mobile_phone,
      email:@patient34.email,
      credential_type_number:@patient34.credential_type_number,
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
      mobile_phone:@patient35.mobile_phone,
      email:@patient35.email,
      credential_type_number:@patient35.credential_type_number,
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
      mobile_phone:@patient36.mobile_phone,
      email:@patient36.email,
      credential_type_number:@patient36.credential_type_number,
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
      mobile_phone:@patient37.mobile_phone,
      email:@patient37.email,
      credential_type_number:@patient37.credential_type_number,
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
      mobile_phone:@patient38.mobile_phone,
      email:@patient38.email,
      credential_type_number:@patient38.credential_type_number,
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
      mobile_phone:@patient39.mobile_phone,
      email:@patient39.email,
      credential_type_number:@patient39.credential_type_number,
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
      mobile_phone:@patient40.mobile_phone,
      email:@patient40.email,
      credential_type_number:@patient40.credential_type_number,
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
      mobile_phone:@patient41.mobile_phone,
      email:@patient41.email,
      credential_type_number:@patient41.credential_type_number,
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
      mobile_phone:@patient42.mobile_phone,
      email:@patient42.email,
      credential_type_number:@patient42.credential_type_number,
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
      mobile_phone:@patient43.mobile_phone,
      email:@patient43.email,
      credential_type_number:@patient43.credential_type_number,
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
      mobile_phone:@patient44.mobile_phone,
      email:@patient44.email,
      credential_type_number:@patient44.credential_type_number,
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
      mobile_phone:@patient45.mobile_phone,
      email:@patient45.email,
      credential_type_number:@patient45.credential_type_number,
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
      mobile_phone:@patient46.mobile_phone,
      email:@patient46.email,
      credential_type_number:@patient46.credential_type_number,
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
      mobile_phone:@patient47.mobile_phone,
      email:@patient47.email,
      credential_type_number:@patient47.credential_type_number,
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
      mobile_phone:@patient48.mobile_phone,
      email:@patient48.email,
      credential_type_number:@patient48.credential_type_number,
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
      mobile_phone:@patient49.mobile_phone,
      email:@patient49.email,
      credential_type_number:@patient49.credential_type_number,
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
      mobile_phone:@patient50.mobile_phone,
      email:@patient50.email,
      credential_type_number:@patient50.credential_type_number,
      remember_token: '',created_by:@user1.name    ,level:''
  )
end

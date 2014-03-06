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
      id: 113933171427,
      name: '田学军',
      password: '123',
      password_confirmation: '123',
      patient_id: '',
      doctor_id: @doctor1.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name   ,level:4
  )
  @user3 = User.create(
      id: 113933171403,
      name: '吴中和',
      password: '123',
      password_confirmation: '123',
      patient_id: '',
      doctor_id: @doctor6.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:4
  )
  @user4 = User.create(
      id: 113933171404,
      name: '李广森',
      password: '123',
      password_confirmation: '123',
      patient_id: '',
      doctor_id: @doctor4.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
  @user5= User.create(
      id: 113933171409,
      name: '张三丰',
      password: '123',
      password_confirmation: '123',
      patient_id: @patient1.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name ,level:4
  )
  @user6 = User.create(
      id: 113933171412,
      name: '蔡祖龙',
      password: '123',
      password_confirmation: '123',
      patient_id: '',
      doctor_id: @doctor19.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
  @user7 = User.create(
      id: 113933171416,
      name: '张无忌',
      password: '123',
      password_confirmation: '123',
      patient_id: @patient2.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:''
  )
  @user8 = User.create(
      id: 113933171417,
      name: '因素素',
      password: '123',
      password_confirmation: '123',
      patient_id: @patient3.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:''
  )
  @user9 = User.create(
      id: 113933171418,
      name: '高元',
      password: '123',
      password_confirmation: '123',
      patient_id: @patient4.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name   ,level:''
  )
  @user10 = User.create(
      id: 113933171419,
      name: '罗卿平',
      password: '123',
      password_confirmation: '123',
      patient_id: @patient5.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name   ,level:''
  )
  @user11 = User.create(
      id: 113933171420,
      name: '马志武',
      password: '123',
      password_confirmation: '123',
      patient_id: @patient6.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
  @user12 = User.create(
      id: 113933171425,
      name: '王肖泽',
      password: '123',
      password_confirmation: '123',
      patient_id: '',
      doctor_id: @doctor3.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
  @user13 = User.create(
      id: 113933171426,
      name: '张军',
      password: '123',
      password_confirmation: '123',
      patient_id: '',
      doctor_id: @doctor8.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name  ,level:4
  )
end

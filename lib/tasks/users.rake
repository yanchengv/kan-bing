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
      id: 113933171407,
      name: '3305',
      password: '123',
      password_confirmation: '123',
      patient_id: '',
      doctor_id: @doctor10.id,
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name   ,level:4
  )
  @user3 = User.create(
      id: 113933171403,
      name: '3302',
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
      name: '3306',
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
      name: '3301',
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
      name: '3310',
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
      name: '3303',
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
      name: '3304',
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
      name: 'p4',
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
      name: 'p5',
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
      name: 'p6',
      password: '123',
      password_confirmation: '123',
      patient_id: @patient6.id,
      doctor_id: '',
      nurse_id: '', manager_id:'',
      is_enabled: true,
      remember_token: '',created_by:@user1.name    ,level:''
  )
end

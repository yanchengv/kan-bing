# encoding: utf-8
#author:wangfang
require 'rubygems'
#require 'ruby-hl7'
require 'socket'
class Appointment < ActiveRecord::Base
  before_create :set_pk_code
  after_create :minas_sync_create
  before_update :minas_sync_update
  belongs_to :patient, :foreign_key => :patient_id
  belongs_to :doctor, :foreign_key => :doctor_id
  belongs_to :hospital, :foreign_key => :hospital_id
  belongs_to :department, :foreign_key => :department_id
  belongs_to :dictionary, :foreign_key => :dictionary_id

  attr_accessible :id, :patient_id, :doctor_id, :appointment_day, :appointment_time, :status, :hospital_id, :department_id, :appointment_avalibleId, :dictionary_id
  def self.authAppointment(patientId, appointmentId)
    @appointmentMsg = ""
    avalid = false
    user = Appointmentblacklist.find_by(patient_id:patientId)
    if  !user.nil? && user.id > 0 && user.unlock_time > Time.now
      @appointmentMsg = "对不起,您暂时无法获取预约服务"
    else
      # 查询三个月内的预约次数
      appointment_threemoth = Appointment.where('"patient_id" = ?  AND  "appointment_day"  >=  ?', patientId, 3.months.ago).count
      appointment_thisweek = Appointment.where('"patient_id" = ?  AND  "appointment_day"  >=  ?', patientId,7.day.ago).count
      appointment = AppointmentAvalible.find(appointmentId);
      doctorId = appointment.avalibledoctor_id
      doctor = Doctor.find(doctorId)
      departmentId = doctor.department_id
      hospitalId = doctor.hospital_id
      app_day = appointment.avalibleappointmentdate
      appointment_current = Appointment.where('"patient_id" = ?  AND  "appointment_day"  =  ?  AND  "department_id" = ? AND "hospital_id" = ?', patientId, app_day, departmentId,hospitalId).count
      appointment_date = Appointment.where('"patient_id" = ? AND "appointment_day" = ?',patientId, app_day).count
      if appointment_threemoth >= 5
        @appointmentMsg ="对不起,您在三月内预约不能超过5次"
      elsif  appointment_thisweek >=3
        @appointmentMsg ="对不起,您在一周内预约不能超过3次"
      elsif   appointment_current >=1
        @appointmentMsg ="对不起,您在同一就诊日、同一医院、同一科室只能预约一次"
      elsif appointment_date >=2
        @appointmentMsg ="对不起,您在同一就诊日的预约总量不可超过两次"
      end
      if  appointment_threemoth < 5 && appointment_thisweek <3 && appointment_date < 2 && appointment_current < 1
        avalid = true
      end
    end
    return avalid
  end
  def set_pk_code
    self.id = pk_id_rules
  end
  def pk_id_rules
    require 'securerandom'
    random=SecureRandom.random_number(9999)
    time=Time.now.to_i
    id=(Settings.pk_rules.yuyuan+time.to_s+random.to_s).to_i
    return id
  end

  def minas_sync_update
    @str = {}
    self.changes.each do |k, v|
      @str[k.to_sym]=v[1]
    end
    @minas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'Appointment',  :code => 3, :contents => @str.to_json(:except => [:updated_at]).to_s)
    @minas.save
  end

  def minas_sync_create
    @minas = MimasDataSyncQueue.new(:foreign_key => self.id, :table_name => 'Appointment',  :code => 1, :contents => '')
    @minas.save
  end
  include SessionsHelper
end

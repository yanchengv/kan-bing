#author:wangfang
class AppointmentSchedule < ActiveRecord::Base
  belongs_to :dictionary, :foreign_key => :dictionary_id
  has_many :appointment_avalibles
  attr_accessible :avalailbecount, :dayofweek, :doctor_id, :timeblock, :dictionary_id
end

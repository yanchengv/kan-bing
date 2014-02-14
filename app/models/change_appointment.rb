class ChangeAppointment < ActiveRecord::Base
  belongs_to :appointment, :foreign_key => :appointment_id
  attr_accessible :id,
                  :appointment_id,
                  :hospital_id
end

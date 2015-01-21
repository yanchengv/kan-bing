class EduVideo < ActiveRecord::Base
  belongs_to :video_type, :foreign_key => :video_type_id
  attr_accessible :id,:name,:content,:doctor_name,:video_time,:image_url,:video_url,:doctor_id,:video_type_id,:hospital_id,:department_id,:view_permission
  belongs_to :doctor
end

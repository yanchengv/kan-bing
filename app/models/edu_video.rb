class EduVideo < ActiveRecord::Base
  attr_accessible :id,:name,:content,:doctor_name,:video_time,:image_url,:video_url,:doctor_id
  belongs_to :doctor
end

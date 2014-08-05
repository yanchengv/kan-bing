class VideoType < ActiveRecord::Base
  has_many :edu_videos, dependent: :destroy
  attr_accessible :id, :type_name
end

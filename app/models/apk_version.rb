class ApkVersion < ActiveRecord::Base
  attr_accessible :id, :version_num, :version_url, :update_time, :description
end
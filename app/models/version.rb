class Version < ActiveRecord::Base
  attr_accessible :id, :version_num, :url, :update_time, :change_content
end
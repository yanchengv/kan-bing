class ArchiveQueue < ActiveRecord::Base  
  attr_accessible  :user_id, :user_name,:uploadfile_type,:filename, :filesize, :extname, :table_name,   :pk,   :status 
end 
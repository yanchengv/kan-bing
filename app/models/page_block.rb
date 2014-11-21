class PageBlock < ActiveRecord::Base
  include SessionsHelper
  attr_accessible :id, :name, :content, :created_id, :created_name, :updated_id, :updated_name, :hospital_id, :hospital_name, :department_id, :department_name, :page_id, :position, :is_show

end

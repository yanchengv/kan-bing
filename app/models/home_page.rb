class HomePage < ActiveRecord::Base
  belongs_to :home_menu, :dependent => :destroy, :foreign_key => :home_menu_id
  attr_accessible :home_menu_id, :name, :content, :hospital_id, :department_id, :position, :link_url
end

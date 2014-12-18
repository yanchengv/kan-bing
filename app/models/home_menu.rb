class HomeMenu < ActiveRecord::Base
  attr_accessible  :name, :parent_id, :hospital_id, :department_id, :show_in_menu, :link_url, :skip_to_first_child, :show_in_header, :show_in_footer, :depth, :content
end
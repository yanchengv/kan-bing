class Skill < ActiveRecord::Base
  attr_accessible :name, :photo, :desc, :detail, :period, :from, :create_by_user

end

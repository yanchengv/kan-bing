class Skill < ActiveRecord::Base

  attr_accessible :name, :desc, :period, :from, :create_by_user
end

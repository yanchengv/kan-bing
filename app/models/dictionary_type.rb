#author:wangfang
class DictionaryType < ActiveRecord::Base
  validates :name, presence: true
  has_many :dictionaries
  attr_accessible :id,:code, :description, :name
end

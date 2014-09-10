class Province < ActiveRecord::Base
  has_many :cities, :dependent => :destroy
  has_many :hospitals , :dependent => :destroy
  has_many :doctors, :dependent => :destroy
  has_many :patients, :dependent => :destroy
  attr_accessible :name, :short_name, :spell_name, :en_abbreviation
end

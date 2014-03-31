class MimasDatasyncResult < ActiveRecord::Base
  attr_accessible :fk,:status,:data_source,:table_name,:hospital,:department,:content

end

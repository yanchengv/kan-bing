class PacsFileRef < ActiveRecord::Base
  self.table_name = "file_ref"
  belongs_to :pacs_instance#, :foreign_key => :pk
  establish_connection "pacs_system"
end
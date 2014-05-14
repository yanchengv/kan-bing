class PacsFileRef < ActiveRecord::Base
  attr_accessible :pk, :created_time, :file_digest, :filepath, :file_size, :file_tsuid, :filesystem_fk, :instance_fk
  self.table_name = "file_ref"
  belongs_to :pacs_instance#, :foreign_key => :pk
  belongs_to :pacs_filesystem
  establish_connection "pacs_system"
end
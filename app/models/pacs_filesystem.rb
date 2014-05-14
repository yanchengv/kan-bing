class PacsFilesystem < ActiveRecord::Base
  attr_accessible :pk, :availability, :fs_group_id, :fs_status, :fs_uri, :next_fk
  self.table_name = "filesystem"
  has_many :pacs_file_refs, :dependent => :destroy, foreign_key: :filesystem_fk
  establish_connection "pacs_system"
end
class PacsInstance < ActiveRecord::Base
  self.table_name = "instance"
  belongs_to :pacs_seriese
  has_many :pacs_file_refs, :dependent => :destroy, foreign_key: :instance_fk
  establish_connection "pacs_system"
end
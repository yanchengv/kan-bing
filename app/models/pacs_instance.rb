class PacsInstance < ActiveRecord::Base
  attr_accessible :pk, :archived, :availability, :sr_complete, :content_date, :content_time, :created_time, :inst_attrs, :ext_retr_aet, :inst_custom1, :inst_custom2, :inst_custom3, :inst_no, :replaced, :retrieve_aets, :sop_cuid, :sop_iuid, :updated_time, :sr_verified, :srcode_fk, :series_fk
  self.table_name = "instance"
  belongs_to :pacs_seriese
  has_many :pacs_file_refs, :dependent => :destroy, foreign_key: :instance_fk
  establish_connection "pacs_system"
end
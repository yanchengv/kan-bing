class Note < ActiveRecord::Base
  #has_many_kindeditor_assets :attachments, :dependent => :destroy
  has_many :note_admireds
  has_many :note_comments
  has_many :note_forwardings
  has_many :note_tags
  belongs_to :note_type
  belongs_to :user
  attr_accessible :head, :subhead, :content, :archtype, :deleted_at, :is_public, :is_top, :is_allow_comment, :is_visible, :who_deleted, :created_by, :created_by_id, :update_by, :update_by_id, :audit_by, :audit_time, :pubstatus, :excellent, :indexpage, :site, :pageview, :replies_count, :doctor_id
end

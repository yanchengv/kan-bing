class Note < ActiveRecord::Base
  has_many :note_admireds
  has_many :note_comments
  has_many :note_forwardings
  attr_accessible :head, :subhead, :content, :archtype, :deleted_at, :is_public, :is_top, :is_allow_comment, :is_visible, :who_deleted, :created_by, :created_by_id, :update_by, :update_by_id, :audit_by, :audit_time, :pubstatus, :excellent, :indexpage, :site, :pageview, :replies_count
end
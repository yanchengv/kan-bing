class Note < ActiveRecord::Base
  #has_many_kindeditor_assets :attachments, :dependent => :destroy
  scope :publiced,               -> { where(is_public: true) }
  has_many :note_admireds, :dependent => :destroy
  has_many :note_comments, :dependent => :destroy
  has_many :note_forwardings, :dependent => :destroy
  has_many :note_tags, :dependent => :destroy
  belongs_to :note_type
  belongs_to :user
  belongs_to :doctor
  has_many :shares, :dependent => :destroy
  attr_accessible :head, :subhead, :content, :archtype, :deleted_at, :is_public, :is_top, :is_allow_comment, :is_visible, :who_deleted, :created_by, :created_by_id, :update_by, :update_by_id, :audit_by, :audit_time, :pubstatus, :excellent, :indexpage, :site, :pageview, :replies_count, :doctor_id

  before_save  :check_public_status

  def check_public_status
    if  self.head.nil? || self.content.nil?

    else
      if !(self.head.empty?)   || !(self.content.empty?)
        self.is_public  = true
      elsif  (self.head.empty?   && self.content.empty?)
        self.is_public  = false
      else
        self.is_public  = false
      end
    end

  end

end

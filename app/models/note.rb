class Note < ActiveRecord::Base
  #has_many_kindeditor_assets :attachments, :dependent => :destroy
  scope :publiced, -> { where(is_public: true) }
  has_many :note_admireds, :dependent => :destroy
  has_many :note_comments, :dependent => :destroy
  has_many :note_forwardings, :dependent => :destroy
  has_many :note_tags, :dependent => :destroy
  belongs_to :note_type
  belongs_to :user
  belongs_to :doctor
  has_many :shares, :dependent => :destroy
  before_create :set_pk_code
  attr_accessible :head, :subhead, :content, :archtype, :deleted_at, :is_public, :is_top, :is_allow_comment, :is_visible, :who_deleted, :created_by, :created_by_id, :update_by, :update_by_id, :audit_by, :audit_time, :pubstatus, :excellent, :indexpage, :site, :pageview, :replies_count, :doctor_id

  before_save :check_public_status

  def check_public_status
    if  self.head.nil? || self.content.nil?

    else
      if !(self.head.empty?) || !(self.content.empty?)
        self.is_public = true
      elsif  (self.head.empty? && self.content.empty?)
        self.is_public = false
      else
        self.is_public = false
      end
    end

  end

  def share
    if self.doctor_id && Doctor.exists?(self.doctor_id)
      pats = self.doctor.patfriends
      pats.each do |pat|
        if pat.user
          pu = pat.user
          Share.create(:note_id => self.id,
                       :from_user_id => self.created_by_id,
                       :from_user_name => self.created_by,
                       :share_user_id => pu.id,
                       :share_user_name => pu.name);
        end
      end
    end
  end

  def cancelShare

  end

  def set_pk_code
    if self.id&&self.id!=0
      self.id = id
    else
      self.id = pk_id_rules
    end
  end


end

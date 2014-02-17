# encoding: utf-8

class Consultation < ActiveRecord::Base
  attr_accessible :id,
                  :owner_id,
                  :patient_id,
                  :init_info,
                  :purpose,
                  :name,
                  :status,
                  :number,
                  :status_description,
                  :created_at,
                  :start_time,
                  :schedule_time,
                  :end_time

  belongs_to :owner, class_name: "Doctor"
  belongs_to :patient
  has_one :channel, :dependent => :destroy
  has_one :cons_report, :dependent => :destroy
  has_many :doctor_lists,:dependent => :destroy
  has_many :docmembers, class_name: "Doctor", :through => :doctor_lists
  has_many :consultation_create_records
  def peerUsers_to_s(exc_usr)
    peer = ''
    if exc_usr.id != owner_id
      peer = peer + owner_id.to_s + ','
    end

    if exc_usr.id != patient_id
      peer = peer + patient_id.to_s + ','
    end

    self.docmembers.each do |member|
      if join?(member.id) && member.id != exc_usr.id
        peer += member.id.to_s + ','
      end
    end
    if peer[peer.length - 1] == ','
      peer = peer[0..-2]
    end
    return peer
  end

  def peerdocids
    peer = []
    if self.docmembers.nil?
      return peer
    end
    self.docmembers.each do |member|
      if join?(member.id)
        peer.append(member.id.to_s)
      end
    end
    return peer
  end
  def peerUsers
    peer = [self.owner,self.patient]
    if self.docmembers.nil?
      return peer
    end
    self.docmembers.each do |member|
      if join?(member.id)
        peer.append(member)
      end
    end
    return peer
  end
  def peerDocNames
    if self.docmembers.nil?
      return "无"
    end
    names = ""
    peer = []
    self.docmembers.each do |member|
      if join?(member.id)
        peer.append(member)
      end
    end
    for u in peer
      names += u.name + ','
    end
    if peer == []
      return "无"
    end
    return names[0..-2]
  end

  def join?(docid)
    @doclist = self.doctor_lists.where("docmember_id = ?",docid)[0]
    return @doclist.confirmed?
  end
  def format_schedule_time
    if self.schedule_time.nil?
      return '没有计划时间'
    else
      return schedul e_time.strftime("%a %b %d %Y %H:%M:%S")
    end
  end
end

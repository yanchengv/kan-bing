#encoding: utf-8
include SessionsHelper
class User< ActiveRecord::Base
  before_create :create_remember_token ,:set_pk_code
  belongs_to :doctor, :foreign_key => :doctor_id
  belongs_to :patient, :foreign_key => :patient_id
  has_many :messages, dependent: :destroy
  has_many :user_feedbacks, dependent: :destroy
  has_many :leave_messages, dependent: :destroy
  has_many :user_replies, dependent: :destroy
  has_many :message_likes, dependent: :destroy
  has_many :notes, :foreign_key => :created_by_id
  has_many :receive_shares     ,:class_name => "Share" ,:foreign_key => :share_user_id    #（用户收到的分享记录  ok）
  has_many :note_types, foreign_key: "create_by_id"
  has_many :note_tags, foreign_key: "created_by_id"
  has_many :create_consult_questions, :class_name => "ConsultQuestion", :foreign_key => "created_by", dependent: :destroy
  has_many :consult_results, :foreign_key => :created_by
  has_many :by_consult_questions, :class_name => "ConsultQuestion", :foreign_key => "consulting_by" ,dependent: :destroy
  has_many :consult_accuses, :foreign_key => 'created_by'
  attr_reader :password
  attr_accessible :id, :name, :password, :password_confirmation, :patient_id, :doctor_id, :nurse_id, :is_enabled,:credential_type_number,
                  :remember_token  ,:created_by   ,:manager_id  ,:level,:technician_id,:password_digest,:p_user_id,:mobile_phone,:email,:md5id,:nick_name,:verification_code,:registered_hospital,:real_name
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, format: {with: VALID_EMAIL_REGEX},
  #          uniqueness: {case_sensitive: false, message: "该邮箱已被使用，请确认！"}, presence: false
  #validates :name, presence: true , :uniqueness => true
  #validates :credential_type_number,
  #          :uniqueness => {:case_sensitive => false, message: "该证件号已被使用，请确认！"}#, presence: true
  #validates :mobile_phone, presence: true , :uniqueness => true
  attr_reader :password
  has_secure_password :validations => false

  has_many :group_users
  #has_many :paticipated_groups ,:through => :group_users , :source => :group
  has_many :groups ,:through => :group_users , :source => :group
  has_many :item_users
  has_many :joined_items ,:through => :item_users ,:source => :item

  #join group
  def join!(args)
    if args.instance_of?(Group)
      self.doctor.groups << args
    elsif args.instance_of?(Item)
      joined_items << args
    end
  end

  def quit!(args)
    if args.instance_of?(Group)
      paticipated_groups.delete(args)
    elsif args.instance_of?(Item)
      joined_items.delete(args)
    end
  end

  def is_member_of?(group)
    paticipated_groups.include?(group)
  end

  def is_join_of?(item)
    #paticipated_groups.include?(group)
    joined_items.include?(item)
  end


  #def join!(group)
  #  paticipated_groups << group
  #end
  #
  #def quit!(group)
  #  paticipated_groups.delete(group)
  #end

  #获取登录用户收到的文章分享
  def receive_share_notes
    ids =[]
    rs_ids = self.receive_share_ids
    shares = Share.select("note_id").find(rs_ids)
    shares.each do|share|
      ids.push(share.note_id)
    end
    return Note.where(id: ids).limit(6).publiced
  end

  #医生用户创建后系统默认的文章分类
  def init_note_type
    if self.doctor_id
      NoteType.create(:name => '论文类文章', :create_by_id => self.doctor_id, :notes_count => 0, :source_by => 0)
      NoteType.create(:name => '疾病预防类文章', :create_by_id => self.doctor_id, :notes_count => 0, :source_by => 0)
      NoteType.create(:name => '肿瘤类文章', :create_by_id => self.doctor_id, :notes_count => 0, :source_by => 0)
      NoteType.create(:name => '心脑血管类文章', :create_by_id => self.doctor_id, :notes_count => 0, :source_by => 0)
    end
  end
  def set_pk_code
    if self.id&&self.id!=0
      self.id = self.id.to_i
    else
      self.id = pk_id_rules
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def userrealname
    if !self.doctor.nil?
      return self.doctor.name
    end
    if !self.patient.nil?
      return self.patient.name
    end
    return self.name
  end
  def roleid
    if !self.doctor_id.nil?
      return self.doctor_id
    end
    if !self.patient_id.nil?
      return self.patient_id
    end
    return self.id
  end
  def managed_cons
    if self.doctor.nil?
      return []
    else
      return Consultation.find_all_by_owner_id(self.doctor_id)
    end
  end
  def joined_cons
    cons = []
    #cons.concat(Consultation.find_all_by_owner_id(user_id))
    if !self.patient.nil?
      cons.concat(Consultation.find_all_by_patient_id(self.patient_id))
    end
    if !self.doctor.nil?
      DoctorList.find_all_by_docmember_id(self.doctor_id).each do |doclist|
        if doclist.consultation.join?(self.doctor_id)
          cons.append(doclist.consultation)
        end
      end
    end
    return cons
  end
  def applied_cons
    if self.doctor.nil?
      return []
    else
      return ConsOrder.find_all_by_owner_id(self.doctor_id)
    end
  end
  def invited_cons
    cons = []
    if !self.doctor.nil?
      DoctorList.find_all_by_docmember_id(self.doctor_id).each do |doclist|
        if !doclist.consultation.join?(self.doctor_id)
          cons.append(doclist.consultation)
        end
      end
    end
    return cons
  end
  def invited_master_cons
    if self.doctor.nil?
      return []
    else
      return ConsOrder.find_all_by_consignee_id(self.doctor_id)
    end
  end

  require 'multi_json'
  include HTTParty

#调用post请求接口
  def post_req(path,params)
    params= {:body=>params}
    @search_result=HTTParty.post(Settings.cis+path,params)
  end

#根据令牌调用接口查找当前用户
  def find_by_remember_token(remember_token)
    path='sessions/find_user?remember_token='+remember_token.to_s
    @search_result = self.get_req(path)
    if @search_result['success']
      return @search_result['data']
    else
      return nil
    end
  end

#调用get请求接口
  def get_req(path)
    @search_result=HTTParty.get(Settings.cis+path)
  end

#调用put请求接口
  def put_req(path,data)
    uri = CIS_URL+path
    c = Curl::Easy.new(uri)
    c.http_put(data)
    @search_result = c.body_str
  end

#调用delete请求接口
  def del_req(path)
    puts 'del_req'
    @search_result=HTTParty.delete(Settings.cis+path)
  end
 #主建生成规则
  def create_pk
    require 'securerandom'
    random=SecureRandom.random_number(9999)
    time=Time.now.to_i
    id=(Settings.hospital_code.yuquan+time.to_s+random.to_s).to_i
    return id
  end

  #上传文件生成uuid
  def uuid(suffix)
    uuid = UUIDTools::UUID.random_create.to_s
    uuid = uuid.gsub('-','')+suffix
    #uuid = uuid[1,2]+'/'+uuid[4,2]+'/'+uuid[7,2]+'/'+uuid[10,100]
  end
  #生成上传文件的目录
  def create_folder_by_uuid(uuid)
    folder='/dfs/jpg/'
    if !File.exist?(folder)
      Dir.mkdir(folder)
    end
    folder_2 = "#{folder}"+uuid[1,2]+"/"
    if !File.exist?(folder_2)
      Dir.mkdir(folder_2)
    end
    folder_3 = "#{folder_2}"+uuid[4,2]+"/"
    if !File.exist?(folder_3)
      Dir.mkdir(folder_3)
    end
    folder_4 = "#{folder_3}"+uuid[7,2]+"/"
    if !File.exist?(folder_4)
      Dir.mkdir(folder_4)
    end
    #image_path=/dfs/6f/c7/dc/bd4e17bad466d6f1a5b2f9.jpg
    image_path = folder_4+uuid[10,100]
    image_path
  end
  private
  def create_remember_token
    #Create the token
    self.remember_token=User.encrypt(User.new_remember_token)
  end
end
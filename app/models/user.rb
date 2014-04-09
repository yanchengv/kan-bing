#encoding: utf-8
include SessionsHelper
class User< ActiveRecord::Base
  before_create :create_remember_token #,:set_pk_code
  belongs_to :doctor, :foreign_key => :doctor_id
  belongs_to :patient, :foreign_key => :patient_id
  has_many :messages, dependent: :destroy
  attr_accessible :id, :name, :password, :password_confirmation, :patient_id, :doctor_id, :nurse_id, :is_enabled,:credential_type_number,
                  :remember_token  ,:created_by   ,:manager_id  ,:level,:technician_id,:password_digest,:p_user_id,:mobile_phone,:email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false, message: "该邮箱已被使用，请确认！"}, presence: false
  validates :name, presence: true , :uniqueness => true
  validates :credential_type_number,
            :uniqueness => {:case_sensitive => false, message: "该证件号已被使用，请确认！"}, presence: true
  validates :mobile_phone, presence: true , :uniqueness => true
  attr_reader :password
  has_secure_password :validations => false
  def set_pk_code
    self.id = pk_id_rules
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
  private
  def create_remember_token
    #Create the token
    self.remember_token=User.encrypt(User.new_remember_token)
  end
end
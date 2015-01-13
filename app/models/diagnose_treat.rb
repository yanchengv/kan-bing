# 诊疗表
class DiagnoseTreat < ActiveRecord::Base
  has_many :main_tells,dependent: :destroy
  has_many :diagnose,dependent: :destroy
  has_many :doctor_orders,dependent: :destroy

  after_create :add_main_tell,:add_diagnose,:doctor_order
  attr_accessible :name,:doctor_id,:patient_id,:create_time



  # 添加主诉表
  def add_main_tell
    main_tell_param={}

    main_tell_param[:tell_content]='暂无信息'
    main_tell_param[:doctor_id]=self.doctor_id
    main_tell_param[:patient_id]=self.patient_id
    main_tell_param[:diagnose_treat_id]=self.id
    main_tell_param[:teller]="暂无"
    main_tell_param[:create_time]=self.create_time
    @main_tell=MainTell.new(main_tell_param);
    @main_tell.save;
  end

# 添加诊断表
  def add_diagnose
    diagnose_param={}

    diagnose_param[:name]='暂无信息'
    diagnose_param[:doctor_id]=self.doctor_id
    diagnose_param[:patient_id]=self.patient_id
    diagnose_param[:diagnose_treat_id]=self.id
    diagnose_param[:content]='暂无'
    diagnose_param[:according]=''
    diagnose_param[:create_time]=self.create_time
    @diagnose=Diagnose.new(diagnose_param);
    @diagnose.save;
  end

# 添加医嘱表
  def  doctor_order
    doctor_order_param={}


    doctor_order_param[:doctor_id]=self.doctor_id
    doctor_order_param[:patient_id]=self.patient_id
    doctor_order_param[:diagnose_treat_id]=self.id
    doctor_order_param[:content]='暂无'
    doctor_order_param[:create_time]=self.create_time
    doctor_order_param[:executor]=''
    doctor_order_param[:start_time]=''
    doctor_order_param[:valid_time]=''
    doctor_order_param[:according]='暂无信息'
    doctor_order_param[:order_type]='无'
    @doctor_order=DoctorOrder.new(doctor_order_param);
    @doctor_order.save;
  end
end

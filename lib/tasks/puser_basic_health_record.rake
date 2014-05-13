#encoding:utf-8
namespace :db do
  task seed: :environment do
    make_basic
  end
end
def make_basic
  BasicHealthRecord.delete_all
  BasicHealthRecord.create(
     patient_id:113932081081001,
     blood_type:'AB',
     allergy_history:'青霉素过敏',     #过敏史
     vaccination_history:'乙肝接种',  #疫苗接种史
     disease_history:'心脏病',    #既往病史
     heredopathia_history:'无', #遗传性病史
     health_risk_factor:'',  #健康因素
     is_handicapped:false,  #是否残疾人
     stature:'174', #身高
     handicap_card_number:'' #障碍卡号
  )
  BasicHealthRecord.create(
      patient_id:113932081081002,
      blood_type:'A',
      allergy_history:'',     #过敏史
      vaccination_history:'乙肝接种',  #疫苗接种史
      disease_history:'',    #既往病史
      heredopathia_history:'无', #遗传性病史
      health_risk_factor:'',  #健康因素
      is_handicapped:false,  #是否残疾人
      stature:'172', #身高
      handicap_card_number:'' #障碍卡号
  )
  BasicHealthRecord.create(
      patient_id:113932081081003,
      blood_type:'O',
      allergy_history:'',     #过敏史
      vaccination_history:'乙肝接种',  #疫苗接种史
      disease_history:'',    #既往病史
      heredopathia_history:'无', #遗传性病史
      health_risk_factor:'',  #健康因素
      is_handicapped:false,  #是否残疾人
      stature:'173', #身高
      handicap_card_number:'' #障碍卡号
  )
  BasicHealthRecord.create(
      patient_id:113932081081004,
      blood_type:'O',
      allergy_history:'青霉素过敏',     #过敏史
      vaccination_history:'乙肝接种',  #疫苗接种史
      disease_history:'无',    #既往病史
      heredopathia_history:'无', #遗传性病史
      health_risk_factor:'',  #健康因素
      is_handicapped:false,  #是否残疾人
      stature:'173', #身高
      handicap_card_number:'' #障碍卡号
  )

end
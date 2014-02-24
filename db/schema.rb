# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140220023522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointment_arranges", force: true do |t|
    t.integer  "modality_device_id"
    t.string   "time_arrange"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointment_avalibles", force: true do |t|
    t.integer  "avalibledoctor_id",       limit: 8
    t.date     "avalibleappointmentdate"
    t.integer  "avalibletimeblock"
    t.integer  "avaliblecount"
    t.integer  "schedule_id"
    t.integer  "dictionary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointment_cancel_schedules", force: true do |t|
    t.integer  "canceldoctor_id",         limit: 8
    t.date     "canceldate"
    t.integer  "canceltimeblock"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "appointment_schedule_id"
  end

  create_table "appointment_schedules", force: true do |t|
    t.integer  "doctor_id",      limit: 8
    t.integer  "dayofweek"
    t.integer  "timeblock"
    t.integer  "avalailbecount"
    t.integer  "dictionary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointmentblacklists", force: true do |t|
    t.integer  "patient_id",  limit: 8
    t.datetime "unlock_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", id: false, force: true do |t|
    t.integer  "id",                     limit: 8, null: false
    t.integer  "patient_id",             limit: 8
    t.integer  "doctor_id",              limit: 8
    t.date     "appointment_day"
    t.integer  "appointment_time"
    t.string   "status"
    t.integer  "hospital_id"
    t.integer  "department_id"
    t.integer  "appointment_avalibleId"
    t.integer  "dictionary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessments", force: true do |t|
    t.integer  "user_id",         limit: 8
    t.integer  "empirical_value"
    t.text     "note"
    t.string   "type",                      default: "Assessment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "basic_health_records", force: true do |t|
    t.integer  "patient_id",           limit: 8, null: false
    t.string   "blood_type"
    t.string   "allergy_history"
    t.string   "vaccination_history"
    t.string   "disease_history"
    t.string   "heredopathia_history"
    t.string   "health_risk_factor"
    t.boolean  "is_handicapped"
    t.string   "handicap_card_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "basic_health_records", ["patient_id"], name: "index_basic_health_records_on_patient_id", using: :btree

  create_table "change_appointments", force: true do |t|
    t.integer  "appointment_id"
    t.integer  "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.integer  "consultation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cons_orders", force: true do |t|
    t.text     "reason"
    t.string   "status"
    t.string   "status_description"
    t.integer  "owner_id",           limit: 8
    t.integer  "consignee_id",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cons_reports", force: true do |t|
    t.integer  "consultation_id"
    t.text     "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consultation_create_records", force: true do |t|
    t.integer  "consultation_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consultation_create_records", ["consultation_id"], name: "index_consultation_create_records_on_consultation_id", using: :btree

  create_table "consultations", force: true do |t|
    t.integer  "owner_id",           limit: 8
    t.integer  "patient_id",         limit: 8
    t.string   "name"
    t.text     "init_info"
    t.text     "purpose"
    t.string   "status"
    t.string   "status_description"
    t.string   "number"
    t.datetime "start_time"
    t.datetime "schedule_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name",            null: false
    t.string   "short_name"
    t.integer  "hospital_id"
    t.text     "description"
    t.string   "phone_number"
    t.string   "spell_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_type"
  end

  add_index "departments", ["hospital_id"], name: "index_departments_on_hospital_id", using: :btree
  add_index "departments", ["name"], name: "index_departments_on_name", using: :btree
  add_index "departments", ["short_name"], name: "index_departments_on_short_name", using: :btree
  add_index "departments", ["spell_code"], name: "index_departments_on_spell_code", using: :btree

  create_table "dictionaries", force: true do |t|
    t.integer  "dictionary_type_id"
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dictionary_types", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_list_for_orders", force: true do |t|
    t.integer  "docmember_id",  limit: 8
    t.integer  "cons_order_id"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doc_list_for_orders", ["docmember_id", "cons_order_id"], name: "index_doc_list_for_orders_on_docmember_id_and_cons_order_id", unique: true, using: :btree
  add_index "doc_list_for_orders", ["docmember_id"], name: "index_doc_list_for_orders_on_docmember_id", using: :btree

  create_table "doctor_friendships", force: true do |t|
    t.integer  "doctor1_id", limit: 8
    t.integer  "doctor2_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doctor_friendships", ["doctor1_id"], name: "index_doctor_friendships_on_doctor1_id", using: :btree
  add_index "doctor_friendships", ["doctor2_id"], name: "index_doctor_friendships_on_doctor2_id", using: :btree

  create_table "doctor_lists", force: true do |t|
    t.integer  "docmember_id",    limit: 8
    t.integer  "consultation_id"
    t.boolean  "confirmed",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doctor_lists", ["consultation_id"], name: "index_doctor_lists_on_consultation_id", using: :btree
  add_index "doctor_lists", ["docmember_id", "consultation_id"], name: "index_doctor_lists_on_docmember_id_and_consultation_id", unique: true, using: :btree

  create_table "doctors", id: false, force: true do |t|
    t.integer  "id",                     limit: 8,                    null: false
    t.string   "name",                                                null: false
    t.string   "spell_code"
    t.string   "credential_type"
    t.string   "credential_type_number"
    t.string   "gender",                           default: "男",      null: false
    t.date     "birthday",                                            null: false
    t.string   "birthplace"
    t.string   "address"
    t.string   "nationality"
    t.string   "citizenship"
    t.string   "province"
    t.string   "county"
    t.string   "photo"
    t.string   "marriage"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "home_address"
    t.string   "contact"
    t.string   "contact_phone"
    t.string   "home_postcode"
    t.string   "email"
    t.text     "introduction"
    t.integer  "hospital_id"
    t.integer  "department_id"
    t.string   "professional_title"
    t.string   "position"
    t.date     "hire_date"
    t.string   "certificate_number"
    t.string   "expertise"
    t.string   "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_control",                       default: false
    t.string   "code",                             default: "Doctor"
    t.string   "dictionary_ids"
    t.boolean  "is_public",                        default: false
  end

  add_index "doctors", ["credential_type_number"], name: "index_doctors_on_credential_type_number", using: :btree
  add_index "doctors", ["department_id"], name: "index_doctors_on_department_id", using: :btree
  add_index "doctors", ["gender"], name: "index_doctors_on_gender", using: :btree
  add_index "doctors", ["hospital_id"], name: "index_doctors_on_hospital_id", using: :btree
  add_index "doctors", ["is_public"], name: "index_doctors_on_is_public", using: :btree
  add_index "doctors", ["mobile_phone"], name: "index_doctors_on_mobile_phone", using: :btree
  add_index "doctors", ["name"], name: "index_doctors_on_name", using: :btree
  add_index "doctors", ["professional_title"], name: "index_doctors_on_professional_title", using: :btree
  add_index "doctors", ["spell_code"], name: "index_doctors_on_spell_code", using: :btree

  create_table "document_categories", force: true do |t|
    t.string   "ids"
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_templates", force: true do |t|
    t.integer  "department_id", null: false
    t.string   "name",          null: false
    t.string   "category",      null: false
    t.string   "sub_category",  null: false
    t.text     "content",       null: false
    t.integer  "creator",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "document_templates", ["category"], name: "index_document_templates_on_category", using: :btree
  add_index "document_templates", ["creator"], name: "index_document_templates_on_creator", using: :btree
  add_index "document_templates", ["department_id"], name: "index_document_templates_on_department_id", using: :btree
  add_index "document_templates", ["name"], name: "index_document_templates_on_name", using: :btree
  add_index "document_templates", ["sub_category"], name: "index_document_templates_on_sub_category", using: :btree

  create_table "documents", force: true do |t|
    t.string   "name"
    t.integer  "surgery_id"
    t.string   "path"
    t.string   "type"
    t.string   "stage",      default: "pre-operation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examined_items", force: true do |t|
    t.string   "item"
    t.float    "fee"
    t.integer  "examined_position_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examined_positions", force: true do |t|
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_sync_queues", force: true do |t|
    t.string   "fileid"
    t.datetime "starttime"
    t.string   "md5"
    t.string   "suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
  end

  create_table "file_sync_results", force: true do |t|
    t.string   "fileid"
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "md5"
    t.string   "suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
  end

  create_table "functions", force: true do |t|
    t.string   "name",                         null: false
    t.string   "desc"
    t.string   "icon"
    t.string   "spell_code"
    t.string   "action"
    t.boolean  "disabled",     default: false
    t.integer  "viewpanel_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitals", force: true do |t|
    t.string   "name",        null: false
    t.string   "short_name"
    t.string   "spell_code"
    t.string   "address"
    t.string   "phone"
    t.text     "description"
    t.string   "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospitals", ["name"], name: "index_hospitals_on_name", using: :btree
  add_index "hospitals", ["rank"], name: "index_hospitals_on_rank", using: :btree
  add_index "hospitals", ["short_name"], name: "index_hospitals_on_short_name", using: :btree
  add_index "hospitals", ["spell_code"], name: "index_hospitals_on_spell_code", using: :btree

  create_table "inpatient_records", force: true do |t|
    t.integer  "patient_id",            limit: 8, null: false
    t.datetime "admitted_date",                   null: false
    t.string   "inpatient_number",                null: false
    t.integer  "department_id",                   null: false
    t.integer  "inpatient_area_id",               null: false
    t.integer  "bed",                             null: false
    t.date     "confirmed_date"
    t.boolean  "is_under_treatment",              null: false
    t.date     "discharge_date"
    t.text     "discharge_diagnose"
    t.text     "discharge_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspection_reports", id: false, force: true do |t|
    t.integer  "id",          limit: 8, null: false
    t.integer  "patient_id",  limit: 8
    t.string   "parent_type"
    t.string   "child_type"
    t.string   "thumbnail"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_logs", force: true do |t|
    t.string   "user_name"
    t.string   "ip_address"
    t.datetime "login_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "login_result"
  end

  create_table "managers", force: true do |t|
    t.string   "name",                                 null: false
    t.string   "spell_code"
    t.string   "credential_type"
    t.string   "credential_type_number",               null: false
    t.string   "gender",                 default: "男", null: false
    t.date     "birthday"
    t.string   "birthplace"
    t.string   "address"
    t.string   "nationality"
    t.string   "citizenship"
    t.string   "province"
    t.string   "country"
    t.string   "photo"
    t.string   "marriage"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "home_address"
    t.string   "contact"
    t.string   "contact_phone"
    t.string   "home_postcode"
    t.string   "email"
    t.string   "introduction"
    t.string   "qq"
    t.string   "weixin"
    t.integer  "level"
    t.datetime "expired_time"
    t.string   "manager_number",                       null: false
    t.string   "authorities"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "managers", ["credential_type_number"], name: "index_managers_on_credential_type_number", using: :btree
  add_index "managers", ["gender"], name: "index_managers_on_gender", using: :btree
  add_index "managers", ["mobile_phone"], name: "index_managers_on_mobile_phone", using: :btree
  add_index "managers", ["name"], name: "index_managers_on_name", using: :btree
  add_index "managers", ["spell_code"], name: "index_managers_on_spell_code", using: :btree

  create_table "medical_records", force: true do |t|
    t.integer  "patient_id",      limit: 8, null: false
    t.string   "service_type_id",           null: false
    t.string   "visit_number",              null: false
    t.integer  "department_id",             null: false
    t.integer  "doctor_id",       limit: 8, null: false
    t.datetime "visit_at",                  null: false
    t.text     "visit"
    t.integer  "pay_type_id"
    t.boolean  "is_admitted"
    t.boolean  "is_closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_surgical_grades", force: true do |t|
    t.integer  "department_id"
    t.string   "name"
    t.string   "category"
    t.string   "doctor_seniority"
    t.string   "nurse_seniority"
    t.string   "note"
    t.string   "spell_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "risk_factor",           default: 0.0
    t.boolean  "is_pollute"
    t.boolean  "is_minimally_invasive"
    t.boolean  "is_isolation"
    t.string   "is_infect"
  end

  create_table "messages", force: true do |t|
    t.text     "content"
    t.integer  "channel_id"
    t.integer  "user_id",    limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mimas_data_sync_queues", force: true do |t|
    t.integer  "foreign_key", limit: 8
    t.string   "table_name"
    t.integer  "code"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "modality_devices", force: true do |t|
    t.string   "station_name"
    t.string   "station_aet"
    t.string   "modality"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.string   "operation_frequence"
  end

  create_table "narcotic_drugs", force: true do |t|
    t.string   "drug_code"
    t.string   "name"
    t.string   "spell_code"
    t.string   "product_name"
    t.string   "english_name"
    t.string   "category"
    t.string   "dosage_forms"
    t.string   "quantity_per"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "net_configs", force: true do |t|
    t.string   "protocol"
    t.string   "host"
    t.string   "port"
    t.string   "config_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "user_id",      limit: 8, null: false
    t.text     "content"
    t.datetime "start_time"
    t.datetime "expired_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "code"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "nurse_groups", force: true do |t|
    t.integer  "empirical_value"
    t.string   "name"
    t.string   "slogan"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "on_duty_date"
    t.integer  "on_duty_of_month"
  end

  create_table "nurses", id: false, force: true do |t|
    t.integer  "id",                     limit: 8,                   null: false
    t.string   "name",                                               null: false
    t.string   "spell_code"
    t.string   "credential_type"
    t.string   "credential_type_number"
    t.string   "gender",                           default: "男",     null: false
    t.date     "birthday",                                           null: false
    t.string   "birthplace"
    t.string   "address"
    t.string   "nationality"
    t.string   "citizenship"
    t.string   "province"
    t.string   "county"
    t.string   "photo"
    t.string   "marriage"
    t.string   "mobile_phone",                                       null: false
    t.string   "home_phone"
    t.string   "home_address"
    t.string   "contact"
    t.string   "contact_phone"
    t.string   "home_postcode"
    t.string   "email"
    t.text     "introduction"
    t.string   "professional_title"
    t.integer  "hospital_id"
    t.integer  "department_id"
    t.date     "hire_date"
    t.string   "certificate_number"
    t.string   "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                             default: "Nurse"
    t.integer  "nurse_group_id"
  end

  add_index "nurses", ["credential_type_number"], name: "index_nurses_on_credential_type_number", using: :btree
  add_index "nurses", ["department_id"], name: "index_nurses_on_department_id", using: :btree
  add_index "nurses", ["gender"], name: "index_nurses_on_gender", using: :btree
  add_index "nurses", ["hospital_id"], name: "index_nurses_on_hospital_id", using: :btree
  add_index "nurses", ["mobile_phone"], name: "index_nurses_on_mobile_phone", using: :btree
  add_index "nurses", ["name"], name: "index_nurses_on_name", using: :btree
  add_index "nurses", ["professional_title"], name: "index_nurses_on_professional_title", using: :btree
  add_index "nurses", ["spell_code"], name: "index_nurses_on_spell_code", using: :btree

  create_table "operating_rooms", force: true do |t|
    t.string   "name"
    t.string   "room_location"
    t.string   "cleanliness_level"
    t.string   "description"
    t.string   "categery"
    t.string   "spell_code"
    t.string   "ventilator"
    t.string   "anesthesia_machine"
    t.string   "specification"
    t.string   "note"
    t.boolean  "is_used",            default: false
    t.text     "configs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operating_rooms_nurse_groups", force: true do |t|
    t.integer  "operating_room_id"
    t.integer  "nurse_group_id"
    t.date     "on_duty_date"
    t.integer  "on_duty_of_week"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operating_rooms_video_sources", force: true do |t|
    t.integer  "operating_room_id"
    t.integer  "video_source_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_surgery_risks", force: true do |t|
    t.integer  "surgery_id"
    t.integer  "upper_limit"
    t.integer  "lower_limit"
    t.float    "risk_factor"
    t.boolean  "gender"
    t.integer  "habitus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", id: false, force: true do |t|
    t.integer  "id",                     limit: 8, null: false
    t.string   "name"
    t.string   "spell_code"
    t.string   "credential_type"
    t.string   "credential_type_number"
    t.string   "gender"
    t.date     "birthday"
    t.string   "birthplace"
    t.string   "address"
    t.string   "nationality"
    t.string   "citizenship"
    t.string   "province"
    t.string   "county"
    t.string   "photo"
    t.string   "marriage"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "home_address"
    t.string   "contact"
    t.string   "contact_phone"
    t.string   "home_postcode"
    t.string   "email"
    t.text     "introduction"
    t.string   "patient_ids"
    t.string   "education"
    t.string   "household"
    t.string   "occupation"
    t.string   "orgnization"
    t.string   "orgnization_address"
    t.string   "insurance_type"
    t.string   "insurance_number"
    t.integer  "doctor_id",              limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_public"
    t.integer  "p_user_id",              limit: 8
  end

  create_table "pay_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "spell_name"
    t.string   "en_abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qualification_certificates", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "spell_code"
    t.string   "certificate_type"
    t.string   "issuing_agency"
    t.date     "issuing_date"
    t.text     "description"
    t.string   "person_type"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recorded_videos", force: true do |t|
    t.integer  "video_source_id"
    t.string   "video_id"
    t.datetime "record_time"
    t.integer  "duration"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "surgery_id"
    t.string   "name"
  end

  create_table "service_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgeries", force: true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.string   "surgery_level"
    t.boolean  "is_minimally_invasive"
    t.boolean  "is_pollute"
    t.boolean  "is_isolation"
    t.boolean  "is_infect"
    t.string   "nurse_visited_uids"
    t.string   "anaesthesia_visited_uids"
    t.datetime "schedule_time"
    t.decimal  "duration"
    t.integer  "inpatient_record_id"
    t.integer  "patient_id",                limit: 8
    t.text     "preoperative_diagnosis"
    t.integer  "master_doctor_id",          limit: 8
    t.string   "assistant_doctor_id"
    t.boolean  "is_emgency"
    t.integer  "doctor_advice_id",          limit: 8
    t.datetime "apply_time",                          default: '2014-02-24 16:16:37'
    t.integer  "apply_doctor_id",           limit: 8
    t.text     "notes"
    t.integer  "arranger_doctor_id",        limit: 8
    t.integer  "anesthesia_doctor_id",      limit: 8
    t.datetime "surgery_time"
    t.integer  "operating_room_id"
    t.integer  "anaesthesia_plan_id"
    t.integer  "patrol_nurse_id",           limit: 8
    t.integer  "appliance_nurse_id",        limit: 8
    t.datetime "actual_start_time"
    t.datetime "actual_end_time"
    t.string   "surgery_status"
    t.boolean  "is_ended"
    t.string   "ended_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "check_uids"
    t.integer  "medical_record_id"
    t.string   "type",                                default: "Surgery"
    t.integer  "medical_surgical_grade_id"
  end

  create_table "surgeries_operating_rooms", force: true do |t|
    t.integer  "surgery_id",                     null: false
    t.integer  "operating_room_id",              null: false
    t.integer  "anesthesia_doctor_id", limit: 8
    t.integer  "arranger_doctor_id",   limit: 8
    t.datetime "started_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgery_doctors", force: true do |t|
    t.integer  "surgery_id"
    t.integer  "doctor_id",   limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doctor_name"
  end

  create_table "surgery_documents", force: true do |t|
    t.integer  "surgery_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgery_drug_dosages", force: true do |t|
    t.string   "drug_name"
    t.string   "drug_no"
    t.decimal  "usage_amount"
    t.string   "quantity_per"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "surgery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgery_drugs", force: true do |t|
    t.integer  "surgery_id"
    t.string   "drug_name"
    t.string   "drug_unit"
    t.decimal  "drug_dosage"
    t.datetime "drug_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgery_logs", force: true do |t|
    t.integer  "surgery_id"
    t.string   "surgery_name"
    t.integer  "patient_id",      limit: 8
    t.string   "patient_name"
    t.string   "operate_action"
    t.integer  "operate_by_id",   limit: 8
    t.string   "operate_by_name"
    t.string   "msg_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "related_model"
    t.text     "log_detail"
  end

  create_table "surgery_nurses", force: true do |t|
    t.integer  "surgery_id"
    t.integer  "nurse_id",           limit: 8
    t.integer  "appliance_nurse_id", limit: 8
    t.datetime "started_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgery_type_operating_rooms", force: true do |t|
    t.integer  "surgery_id"
    t.integer  "operating_room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgical_instrument_instances", force: true do |t|
    t.integer  "surgical_instrument_id"
    t.integer  "operating_room_id"
    t.string   "equipment_code"
    t.string   "name"
    t.string   "spell_code"
    t.string   "product_name"
    t.string   "english_name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgical_instruments", force: true do |t|
    t.string   "equipment_code"
    t.string   "name"
    t.string   "spell_code"
    t.string   "product_name"
    t.string   "english_name"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "operating_room_id"
  end

  create_table "systems", force: true do |t|
    t.string   "name",       null: false
    t.string   "desc"
    t.string   "icon"
    t.string   "spell_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "technicians", id: false, force: true do |t|
    t.integer  "id",                     limit: 8,                 null: false
    t.string   "name"
    t.string   "spell_code"
    t.string   "credential_type"
    t.string   "credential_type_number"
    t.string   "gender",                           default: "男",   null: false
    t.date     "birthday",                                         null: false
    t.string   "birthplace"
    t.string   "address"
    t.string   "nationality"
    t.string   "citizenship"
    t.string   "province"
    t.string   "county"
    t.string   "photo"
    t.string   "marriage"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "home_address"
    t.string   "contact"
    t.string   "contact_phone"
    t.string   "home_postcode"
    t.string   "email"
    t.string   "introduction"
    t.integer  "hospital_id"
    t.integer  "department_id"
    t.string   "professional_title"
    t.string   "position"
    t.date     "hire_date"
    t.string   "certificate_number"
    t.string   "expertise"
    t.string   "degree"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_public",                        default: false
  end

  add_index "technicians", ["credential_type_number"], name: "index_technicians_on_credential_type_number", using: :btree
  add_index "technicians", ["department_id"], name: "index_technicians_on_department_id", using: :btree
  add_index "technicians", ["gender"], name: "index_technicians_on_gender", using: :btree
  add_index "technicians", ["hospital_id"], name: "index_technicians_on_hospital_id", using: :btree
  add_index "technicians", ["is_public"], name: "index_technicians_on_is_public", using: :btree
  add_index "technicians", ["mobile_phone"], name: "index_technicians_on_mobile_phone", using: :btree
  add_index "technicians", ["name"], name: "index_technicians_on_name", using: :btree
  add_index "technicians", ["professional_title"], name: "index_technicians_on_professional_title", using: :btree
  add_index "technicians", ["spell_code"], name: "index_technicians_on_spell_code", using: :btree

  create_table "treatment_relationships", force: true do |t|
    t.integer  "doctor_id",  limit: 8
    t.integer  "patient_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_quality_controls", force: true do |t|
    t.integer  "report_id",     limit: 8, null: false
    t.integer  "operator_id",   limit: 8, null: false
    t.string   "operate_event",           null: false
    t.text     "description"
    t.string   "document_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "operator_name"
  end

  add_index "us_quality_controls", ["document_id"], name: "index_us_quality_controls_on_document_id", using: :btree
  add_index "us_quality_controls", ["operator_id"], name: "index_us_quality_controls_on_operator_id", using: :btree
  add_index "us_quality_controls", ["report_id"], name: "index_us_quality_controls_on_report_id", using: :btree

  create_table "us_report_doc_logs", force: true do |t|
    t.integer  "report_id",  limit: 8
    t.integer  "doc_uuid",   limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_reports", id: false, force: true do |t|
    t.integer  "id",                  limit: 8,                 null: false
    t.integer  "patient_id",          limit: 8
    t.string   "patient_ids",                                   null: false
    t.integer  "apply_department_id",                           null: false
    t.integer  "apply_doctor_id",     limit: 8,                 null: false
    t.integer  "consulting_room_id"
    t.date     "appointment_time"
    t.integer  "apply_source",                  default: 0
    t.string   "source_code",                                   null: false
    t.integer  "bed_no"
    t.integer  "examined_part_id",                              null: false
    t.integer  "examined_item_id",                              null: false
    t.integer  "charge_type_id"
    t.float    "charge"
    t.integer  "examine_doctor_id",   limit: 8
    t.boolean  "is_emergency",                  default: false
    t.string   "created_by",                                    null: false
    t.string   "modality"
    t.string   "positive_grade"
    t.text     "initial_diagnosis"
    t.integer  "equipment"
    t.integer  "approval_status",               default: 0
    t.datetime "check_start_time"
    t.datetime "check_end_time"
    t.string   "report_document_id"
    t.integer  "controller_by",       limit: 8
    t.text     "follow_up_result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "print_total",                   default: 0
    t.integer  "notification_id"
    t.integer  "technician_id",       limit: 8
  end

  add_index "us_reports", ["apply_department_id"], name: "index_us_reports_on_apply_department_id", using: :btree
  add_index "us_reports", ["apply_doctor_id"], name: "index_us_reports_on_apply_doctor_id", using: :btree
  add_index "us_reports", ["apply_source"], name: "index_us_reports_on_apply_source", using: :btree
  add_index "us_reports", ["appointment_time"], name: "index_us_reports_on_appointment_time", using: :btree
  add_index "us_reports", ["approval_status"], name: "index_us_reports_on_approval_status", using: :btree
  add_index "us_reports", ["charge_type_id"], name: "index_us_reports_on_charge_type_id", using: :btree
  add_index "us_reports", ["check_start_time"], name: "index_us_reports_on_check_start_time", using: :btree
  add_index "us_reports", ["consulting_room_id"], name: "index_us_reports_on_consulting_room_id", using: :btree
  add_index "us_reports", ["controller_by"], name: "index_us_reports_on_controller_by", using: :btree
  add_index "us_reports", ["created_by"], name: "index_us_reports_on_created_by", using: :btree
  add_index "us_reports", ["examine_doctor_id"], name: "index_us_reports_on_examine_doctor_id", using: :btree
  add_index "us_reports", ["examined_item_id"], name: "index_us_reports_on_examined_item_id", using: :btree
  add_index "us_reports", ["examined_part_id"], name: "index_us_reports_on_examined_part_id", using: :btree
  add_index "us_reports", ["is_emergency"], name: "index_us_reports_on_is_emergency", using: :btree
  add_index "us_reports", ["patient_id"], name: "index_us_reports_on_patient_id", using: :btree
  add_index "us_reports", ["patient_ids"], name: "index_us_reports_on_patient_ids", using: :btree
  add_index "us_reports", ["report_document_id"], name: "index_us_reports_on_report_document_id", using: :btree
  add_index "us_reports", ["technician_id"], name: "index_us_reports_on_technician_id", using: :btree

  create_table "us_worklists", force: true do |t|
    t.integer  "patient_id",          limit: 8,                 null: false
    t.string   "patient_ids",                                   null: false
    t.integer  "apply_department_id"
    t.integer  "apply_doctor_id",     limit: 8,                 null: false
    t.integer  "consulting_room_id"
    t.datetime "appointment_time"
    t.integer  "apply_source",                  default: 0
    t.string   "source_code",                                   null: false
    t.integer  "bed_no"
    t.integer  "examined_part_id",                              null: false
    t.integer  "examined_item_id",                              null: false
    t.float    "charge",                        default: 0.0
    t.integer  "examine_doctor_id",   limit: 8
    t.boolean  "is_emergency",                  default: false
    t.string   "created_by"
    t.string   "update_by"
    t.text     "description"
    t.string   "study_iuid"
    t.integer  "status",                        default: 0
    t.string   "modality"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "worklist_code"
    t.integer  "technician_id",       limit: 8
  end

  add_index "us_worklists", ["apply_department_id"], name: "index_us_worklists_on_apply_department_id", using: :btree
  add_index "us_worklists", ["apply_doctor_id"], name: "index_us_worklists_on_apply_doctor_id", using: :btree
  add_index "us_worklists", ["apply_source"], name: "index_us_worklists_on_apply_source", using: :btree
  add_index "us_worklists", ["appointment_time"], name: "index_us_worklists_on_appointment_time", using: :btree
  add_index "us_worklists", ["consulting_room_id"], name: "index_us_worklists_on_consulting_room_id", using: :btree
  add_index "us_worklists", ["created_by"], name: "index_us_worklists_on_created_by", using: :btree
  add_index "us_worklists", ["examine_doctor_id"], name: "index_us_worklists_on_examine_doctor_id", using: :btree
  add_index "us_worklists", ["examined_item_id"], name: "index_us_worklists_on_examined_item_id", using: :btree
  add_index "us_worklists", ["examined_part_id"], name: "index_us_worklists_on_examined_part_id", using: :btree
  add_index "us_worklists", ["is_emergency"], name: "index_us_worklists_on_is_emergency", using: :btree
  add_index "us_worklists", ["modality"], name: "index_us_worklists_on_modality", using: :btree
  add_index "us_worklists", ["patient_id"], name: "index_us_worklists_on_patient_id", using: :btree
  add_index "us_worklists", ["patient_ids"], name: "index_us_worklists_on_patient_ids", using: :btree
  add_index "us_worklists", ["status"], name: "index_us_worklists_on_status", using: :btree
  add_index "us_worklists", ["study_iuid"], name: "index_us_worklists_on_study_iuid", using: :btree

  create_table "users", id: false, force: true do |t|
    t.integer  "id",              limit: 8,                    null: false
    t.string   "name",                                         null: false
    t.string   "password_digest",           default: "123456", null: false
    t.integer  "patient_id",      limit: 8
    t.integer  "doctor_id",       limit: 8
    t.integer  "nurse_id",        limit: 8
    t.boolean  "is_enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "created_by"
    t.integer  "level"
    t.integer  "manager_id"
    t.integer  "technician_id",   limit: 8
  end

  add_index "users", ["doctor_id"], name: "index_users_on_doctor_id", using: :btree
  add_index "users", ["manager_id"], name: "index_users_on_manager_id", using: :btree
  add_index "users", ["nurse_id"], name: "index_users_on_nurse_id", using: :btree
  add_index "users", ["patient_id"], name: "index_users_on_patient_id", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["technician_id"], name: "index_users_on_technician_id", using: :btree

  create_table "users_workspaces", force: true do |t|
    t.integer  "user_id",      limit: 8
    t.integer  "workspace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default",             default: false
  end

  create_table "video_sources", force: true do |t|
    t.integer  "sid"
    t.string   "name"
    t.string   "address"
    t.string   "video_id"
    t.integer  "state",               default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stop_recording_time", default: 0
  end

  add_index "video_sources", ["sid"], name: "index_video_sources_on_sid", unique: true, using: :btree

  create_table "viewpanels", force: true do |t|
    t.string   "name",                              null: false
    t.string   "desc"
    t.string   "icon"
    t.string   "spell_code"
    t.string   "action_url",                        null: false
    t.integer  "system_id",                         null: false
    t.string   "v_controller"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_support_mobile", default: false
  end

  create_table "workspaces", force: true do |t|
    t.string   "name",                               null: false
    t.string   "desc"
    t.string   "icon"
    t.string   "default_view_panel"
    t.text     "menu"
    t.text     "shortcut"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.boolean  "is_support_mobile",  default: false
    t.text     "mobile_menu",        default: ""
  end

end

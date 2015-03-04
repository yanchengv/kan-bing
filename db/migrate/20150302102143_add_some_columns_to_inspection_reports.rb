class AddSomeColumnsToInspectionReports < ActiveRecord::Migration
  def change
    add_column :inspection_ultrasounds, :patient_name, :string
    add_column :inspection_ultrasounds, :patient_code, :string
    add_column :inspection_ultrasounds, :patient_ids, :string
    add_column :inspection_ultrasounds, :apply_department_id, :string
    add_column :inspection_ultrasounds, :apply_department_name, :string

    add_column :inspection_ultrasounds, :apply_doctor_id, :string
    add_column :inspection_ultrasounds, :apply_doctor_name, :string
    add_column :inspection_ultrasounds, :consulting_room_name, :string
    add_column :inspection_ultrasounds, :consulting_room_id, :string
    add_column :inspection_ultrasounds, :apply_source, :string

    add_column :inspection_ultrasounds, :us_order_id, :string
    add_column :inspection_ultrasounds, :bed_no, :string  #床号
    add_column :inspection_ultrasounds, :examined_part_name, :string
    add_column :inspection_ultrasounds, :examined_item_name, :string
    add_column :inspection_ultrasounds, :charge_type, :string #支付类型

    add_column :inspection_ultrasounds, :charge, :float #收费金额
    add_column :inspection_ultrasounds, :examine_doctor_id, :string
    add_column :inspection_ultrasounds, :examine_doctor_name, :string
    add_column :inspection_ultrasounds, :examine_doctor_code, :string
    add_column :inspection_ultrasounds, :qc_doctor_id, :string   #质控医生id

    add_column :inspection_ultrasounds, :qc_doctor_name, :string  #质控医生姓名
    add_column :inspection_ultrasounds, :is_emergency, :boolean  #是否紧急
    add_column :inspection_ultrasounds, :modality_device_id, :string
    add_column :inspection_ultrasounds, :initial_diagnosis, :text
    add_column :inspection_ultrasounds, :qc_status, :string

    add_column :inspection_ultrasounds, :check_start_time, :datetime
    add_column :inspection_ultrasounds, :check_end_time, :datetime
    add_column :inspection_ultrasounds, :print_count, :integer
    add_column :inspection_ultrasounds, :technician_id, :string   #技师id
    add_column :inspection_ultrasounds, :technician_name, :string  #技师姓名

    add_column :inspection_ultrasounds, :inputer_id, :string    #创建报告人
    add_column :inspection_ultrasounds, :inputer_name, :string   #创建人名称
    add_column :inspection_ultrasounds, :report_image_list, :text
    add_column :inspection_ultrasounds, :us_finding, :string      #超声所见
    add_column :inspection_ultrasounds, :us_diagnose, :string     #超声所得

    add_column :inspection_ultrasounds, :statics, :text          #报告统计
    add_column :inspection_ultrasounds, :station_fee, :boolean
    add_column :inspection_ultrasounds, :report_print_fee, :boolean
    add_column :inspection_ultrasounds, :item_fee, :boolean
    add_column :inspection_ultrasounds, :desc_fee, :boolean

    add_index :inspection_ultrasounds, :patient_id
    add_index :inspection_ultrasounds, :apply_doctor_id
    add_index :inspection_ultrasounds, :apply_department_id
    add_index :inspection_ultrasounds, :examine_doctor_id
    add_index :inspection_ultrasounds, :qc_doctor_id
  end
end

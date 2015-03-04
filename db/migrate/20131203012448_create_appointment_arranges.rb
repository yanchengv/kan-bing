class CreateAppointmentArranges < ActiveRecord::Migration
  def change
    create_table :appointment_arranges , :id => false  do |t|
      t.integer :id, :limit => 8
      t.integer :modality_device_id
      t.string :time_arrange

      t.timestamps
    end
    execute "ALTER TABLE appointment_arranges ADD PRIMARY KEY (id);"
  end
end

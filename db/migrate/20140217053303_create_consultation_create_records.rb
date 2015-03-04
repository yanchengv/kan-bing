class CreateConsultationCreateRecords < ActiveRecord::Migration
  def change
    create_table :consultation_create_records do |t|
      t.integer :consultation_id
      t.string :content
      t.timestamps
    end
    add_index :consultation_create_records,:consultation_id
  end
end

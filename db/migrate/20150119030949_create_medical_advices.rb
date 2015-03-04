class CreateMedicalAdvices < ActiveRecord::Migration
  def change
    create_table :medical_advices do |t|
      t.string :title
      t.integer :created_by_id, :limit => 8
      t.string :created_by_name
      t.integer :advice_type_id

      t.timestamps
    end
  end
end

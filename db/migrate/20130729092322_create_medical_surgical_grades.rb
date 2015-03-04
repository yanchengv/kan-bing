class CreateMedicalSurgicalGrades < ActiveRecord::Migration
  def change
    create_table :medical_surgical_grades  do |t|
      t.integer :department_id
    #  t.integer :hospital_id
      t.string :name
      t.string :category
      t.string :doctor_seniority
      t.string :nurse_seniority
      t.string :note
      t.string :spell_code

      t.timestamps
    end
  end
end

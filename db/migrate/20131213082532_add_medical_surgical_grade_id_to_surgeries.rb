class AddMedicalSurgicalGradeIdToSurgeries < ActiveRecord::Migration
  def change
    add_column :surgeries, :medical_surgical_grade_id, :integer
  end
end

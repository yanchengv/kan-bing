class AddRiskFactorToMedicalSurgicalGrades < ActiveRecord::Migration
  def change
    #### risk_factor表示的是手术的风险系数
    add_column :medical_surgical_grades, :risk_factor, :float , :default => 0.0
  end
end

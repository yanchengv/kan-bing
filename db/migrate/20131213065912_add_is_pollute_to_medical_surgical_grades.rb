class AddIsPolluteToMedicalSurgicalGrades < ActiveRecord::Migration
  def change
    add_column :medical_surgical_grades, :is_pollute, :boolean
    add_column :medical_surgical_grades, :is_minimally_invasive, :boolean
    add_column :medical_surgical_grades, :is_isolation, :boolean
    add_column :medical_surgical_grades, :is_infect, :string
  end
end

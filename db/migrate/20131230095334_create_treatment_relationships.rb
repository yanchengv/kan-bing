class CreateTreatmentRelationships < ActiveRecord::Migration
  def change
    create_table :treatment_relationships do |t|
      t.belongs_to  :doctor
      t.belongs_to  :patient

      t.timestamps
    end
  end
end

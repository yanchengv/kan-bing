#encoding:utf-8
class CreateBasicHealthRecords < ActiveRecord::Migration
  def change
    create_table :basic_health_records do |t|
      t.references :patient, index: true  ,:null => false
      t.string :blood_type
      t.string :allergy_history
      t.string :vaccination_history
      t.string :disease_history
      t.string :heredopathia_history
      t.string :health_risk_factor
      t.boolean :is_handicapped
      t.string :handicap_card_number

      t.timestamps
    end

  end
end

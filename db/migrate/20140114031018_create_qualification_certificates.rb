class CreateQualificationCertificates < ActiveRecord::Migration
  def change
    create_table :qualification_certificates do |t|
      t.string :name
      t.string :code
      t.string :spell_code
      t.string :certificate_type
      t.string :issuing_agency
      t.date :issuing_date
      t.text :description
      t.string :person_type
      t.integer :person_id

      t.timestamps
    end
  end
end

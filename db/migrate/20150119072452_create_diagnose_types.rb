class CreateDiagnoseTypes < ActiveRecord::Migration
  def change
    create_table :diagnose_types do |t|
      t.string :type_name

      t.timestamps
    end
  end
end

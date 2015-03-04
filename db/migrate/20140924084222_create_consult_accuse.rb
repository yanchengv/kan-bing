class CreateConsultAccuse < ActiveRecord::Migration
  def change
    create_table :consult_accuses do |t|
      t.text :reason
      t.integer :created_by, :limit => 8
      t.integer :question_id
      t.integer :result_id

      t.timestamps
    end
  end
end

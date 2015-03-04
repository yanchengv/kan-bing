class CreateConsultQuestion < ActiveRecord::Migration
  def change
    create_table :consult_questions do |t|
      t.text :consult_content
      t.integer :consulting_by, :limit => 8
      t.integer :created_by, :limit => 8
      t.integer :consult_identity
      t.integer :privilege_view, :default => 0

      t.timestamps
    end
  end
end

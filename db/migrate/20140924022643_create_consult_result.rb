class CreateConsultResult < ActiveRecord::Migration
  def change
    create_table :consult_results do |t|
      t.text :respond_content
      t.integer :created_by, :limit => 8
      t.integer :respond_identity
      t.integer :consult_id
      t.integer :privilege_view, :default => 0

      t.timestamps
    end
  end
end

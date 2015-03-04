class CreateConsReports < ActiveRecord::Migration
  def change
    create_table :cons_reports do |t|
      t.integer :consultation_id
      t.text :result
      t.timestamps
    end
  end
end

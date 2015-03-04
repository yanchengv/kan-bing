class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.string :name
      t.string :url
      t.integer :hospital_id,limit:8
      t.integer :department_id,limit:8
      t.string  :footer_content
      t.timestamps
    end
  end
end

class CreateDocumentTemplates < ActiveRecord::Migration
  def change
    create_table :document_templates do |t|
      t.integer :department_id, null: false
      t.string :name, null: false
      t.string :category, null: false
      t.string :sub_category, null: false
      t.text :content, null: false
      t.integer :creator, null: false

      t.timestamps
    end

    add_index :document_templates, :department_id
    add_index :document_templates, :name
    add_index :document_templates, :category
    add_index :document_templates, :sub_category
    add_index :document_templates, :creator
  end
end

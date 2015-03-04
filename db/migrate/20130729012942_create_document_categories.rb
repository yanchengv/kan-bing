class CreateDocumentCategories < ActiveRecord::Migration
  def change
    create_table :document_categories do |t|
      t.string :ids
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end

class CreateSurgeryDocuments < ActiveRecord::Migration
  def change
    create_table :surgery_documents do |t|
      t.integer :surgery_id
      t.integer :document_id

      t.timestamps
    end
  end
end

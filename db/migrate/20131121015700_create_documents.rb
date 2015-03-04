class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :surgery_id
      t.string :path
      t.string :type
      t.string :stage, :default => 'pre-operation'

      t.timestamps
    end
  end
end

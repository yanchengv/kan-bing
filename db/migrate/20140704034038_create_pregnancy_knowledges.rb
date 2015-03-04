class CreatePregnancyKnowledges < ActiveRecord::Migration
  def change
    create_table :pregnancy_knowledges do |t|
      t.integer :parent_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :pregnancy_knowledges, :parent_id
  end
end

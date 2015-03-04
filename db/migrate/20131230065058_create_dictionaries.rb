#author:wangfang
class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.integer :dictionary_type_id
      t.string :name
      t.string :code
      t.string :description
      t.timestamps
    end
  end
end

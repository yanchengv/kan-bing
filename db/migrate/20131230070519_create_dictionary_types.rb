#author:wangfang
class CreateDictionaryTypes < ActiveRecord::Migration
  def change
    create_table :dictionary_types do |t|
      t.string :name
      t.string :code
      t.string :description
      t.timestamps
    end
  end
end

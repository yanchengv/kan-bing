class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :name, null: false
      t.string :desc
      t.string :icon
      t.string :spell_code
      t.string :action
      t.boolean :disabled, :default => false
      t.integer :viewpanel_id, null: false

      t.timestamps
    end
  end
end

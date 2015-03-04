class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name , null: false
      t.string :desc
      t.string :icon
      t.string :spell_code

      t.timestamps
    end
  end

end

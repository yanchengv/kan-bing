class CreateViewpanels < ActiveRecord::Migration
  def change
    create_table :viewpanels do |t|
      t.string :name, null: false
      t.string :desc
      t.string :icon
      t.string :spell_code
      t.string :action_url, null: false
      t.integer :system_id, null: false
      t.string :v_controller
      t.timestamps
    end
  end
end

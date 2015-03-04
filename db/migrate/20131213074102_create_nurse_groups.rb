class CreateNurseGroups < ActiveRecord::Migration
  def change
    create_table :nurse_groups do |t|
      t.integer :nurse_id
      t.integer :empirical_value
      t.string :name
      t.string :slogan

      t.timestamps
    end
  end
end

class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :desc
      t.string :photo
      t.string :web_site
      t.integer :create_user_id ,:limit => 8
      t.string :create_user
      t.integer :expert_count
      t.integer :hospital_id ,:limit => 8
      t.integer :sort
      t.timestamps
    end
  end
end

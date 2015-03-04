class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :desc
      t.string :photo
      t.integer :user_id
      t.string :create_user
      t.integer :group_id
      t.string :group_name
      t.timestamps
    end
  end
end

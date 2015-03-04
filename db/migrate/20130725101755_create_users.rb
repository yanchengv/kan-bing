class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name, null: false
      t.string :password_digest, null: false, :default => "123456"
      t.integer :patient_id
      t.integer :doctor_id
      t.integer :nurse_id
      t.boolean :is_enabled

      t.timestamps
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end

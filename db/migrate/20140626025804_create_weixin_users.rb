class CreateWeixinUsers < ActiveRecord::Migration
  def change
    create_table :weixin_users do |t|
      t.string :openid
      t.integer :patient_id, :limit => 8
      t.integer :doctor_id, :limit => 8
      t.timestamps
    end
    add_index :weixin_users, :openid
    add_index :weixin_users, :patient_id
    add_index :weixin_users, :doctor_id
  end
end


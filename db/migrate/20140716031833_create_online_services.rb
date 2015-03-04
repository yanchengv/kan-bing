class CreateOnlineServices < ActiveRecord::Migration
  def change
    create_table :online_services do |t|
      t.integer :service_id
      t.string :service_name
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end

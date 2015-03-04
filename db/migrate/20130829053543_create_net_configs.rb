class CreateNetConfigs < ActiveRecord::Migration
  def change
    create_table :net_configs do |t|
      t.string :protocol
      t.string :host
      t.string :port
      t.string :config_type ,:unique => true

      t.timestamps
    end
  end
end

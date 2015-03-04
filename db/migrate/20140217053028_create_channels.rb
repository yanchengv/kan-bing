class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|

      t.integer  "consultation_id"
      t.timestamps
    end
  end
end

class CreateNoteAdmireds < ActiveRecord::Migration
  def change
    create_table :note_admireds do |t|
      t.integer :user_id, :limit => 8
      t.integer :note_id, :limit => 8

      t.timestamps
    end
  end
end

class CreateNoteComments < ActiveRecord::Migration
  def change
    create_table :note_comments do |t|
      t.integer :user_id, :limit => 8
      t.string :name
      t.integer :note_id, :limit => 8
      t.string :comment

      t.timestamps
    end
  end
end

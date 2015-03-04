class CreateNoteType < ActiveRecord::Migration
  def change
    create_table :note_types do |t|
      t.string :name
      t.integer :create_by_id, :limit => 8
      t.integer :notes_count
      t.integer :source_by
    end
  end
end

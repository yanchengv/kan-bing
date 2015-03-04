class CreateNoteTags < ActiveRecord::Migration
  def change
    create_table :note_tags do |t|
      t.integer :note_id, :limit => 8
      t.string :tag_name
    end
  end
end

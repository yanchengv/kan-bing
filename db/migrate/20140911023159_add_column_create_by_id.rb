class AddColumnCreateById < ActiveRecord::Migration
  def change
    add_column :note_tags, :created_by_id, :integer, :limit => 8
  end
end

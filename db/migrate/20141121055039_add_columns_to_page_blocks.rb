class AddColumnsToPageBlocks < ActiveRecord::Migration
  def change
    add_column :page_blocks, :position, :integer, :default => 0
    add_column :page_blocks, :is_show, :boolean, :default => false
  end
end

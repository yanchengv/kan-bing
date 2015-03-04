class AddBlockTypeToPageBlock < ActiveRecord::Migration
  def change
    add_column :page_blocks, :block_type, :string
  end
end

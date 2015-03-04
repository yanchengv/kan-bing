class AddColumnChangeContentToVersions < ActiveRecord::Migration
  def change
    add_column :versions,:change_content,:text
  end
end

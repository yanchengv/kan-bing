class AddColumnsIsPublicAndPUserIdToPatient < ActiveRecord::Migration
  def up
    add_column :patients, :is_public, :boolean
    add_column :patients, :p_user_id, :integer
  end

  def down
    remove_column :patients, :is_public
    remove_column :patients, :p_user_id
  end
end

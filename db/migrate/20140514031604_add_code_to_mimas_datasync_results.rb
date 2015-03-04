class AddCodeToMimasDatasyncResults < ActiveRecord::Migration
  def change
    add_column :mimas_datasync_results, :code, :integer
  end
end

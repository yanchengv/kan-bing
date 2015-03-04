class AddColumnOperatorNameToUsQualityControl < ActiveRecord::Migration
  def up
  add_column :us_quality_controls, :operator_name, :string
end

def down
  remove_column :us_quality_controls, :operator_name
end
end

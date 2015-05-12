class AddColumnStyleToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :style, :string
  end
end

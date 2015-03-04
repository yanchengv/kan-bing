class AddIsSupportMobileToViewPanel < ActiveRecord::Migration
  def change
    add_column :viewpanels, :is_support_mobile, :boolean  ,:default =>false
  end
end

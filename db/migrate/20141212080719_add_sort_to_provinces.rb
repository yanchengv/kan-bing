class AddSortToProvinces < ActiveRecord::Migration
  def change
    add_column :provinces, :sort, :integer
    add_column :provinces, :indexpage, :boolean

    add_column :hospitals, :sort, :integer
    add_column :hospitals, :indexpage, :boolean


    add_column :doctors, :sort, :integer
    add_column :doctors, :indexpage, :boolean

    add_index :provinces, :sort
    add_index :provinces, :indexpage
    add_index :hospitals, :sort
    add_index :hospitals, :indexpage
    add_index :doctors, :sort
    add_index :doctors, :indexpage

  end
end

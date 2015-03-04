class CreateWebsiteAgreements < ActiveRecord::Migration
  def change
    create_table :website_agreements, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :title
      t.string :doc_type
      t.text :content
      t.string :brief
      t.integer :create_by_id, :limit => 8
      t.string :create_by_name
      t.integer :update_by_id, :limit => 8
      t.string :update_by_name

      t.timestamps
    end
    execute "ALTER TABLE website_agreements ADD PRIMARY KEY (id);"
  end
end

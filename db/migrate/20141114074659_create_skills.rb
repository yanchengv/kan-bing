class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :photo
      t.string :keywords
      t.string :short_name
      t.string :spell_code
      t.string :short_spell
      t.text :desc , :limit => 1004967295
      t.text :detail, :limit => 1004967295
      t.string :period
      t.string :from
      t.string :create_by_user
      t.integer :sort
      t.boolean :index_page_show
      t.timestamps
    end

    add_index :skills, :name
  end
end

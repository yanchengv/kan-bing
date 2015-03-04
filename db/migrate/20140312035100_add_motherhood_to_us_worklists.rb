class AddMotherhoodToUsWorklists < ActiveRecord::Migration
  def change
    add_column :us_worklists, :motherhood, :integer
    add_column :us_worklists, :lastMenstrual, :date
    add_column :us_worklists, :cycle, :integer
  end
end

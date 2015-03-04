class AddColumnDictionaryIdsToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :dictionary_ids,:string
  end
end

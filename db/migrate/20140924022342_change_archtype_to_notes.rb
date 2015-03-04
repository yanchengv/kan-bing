class ChangeArchtypeToNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :archtype
    add_column :notes, :archtype, :integer, :default => 0
  end
end

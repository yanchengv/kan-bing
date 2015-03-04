class AddVerificationCodeToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :verify_code, :string
    add_column :patients, :is_activated, :integer , :default => 0
    add_column :patients, :is_checked, :integer, :default => 0
    add_column :patients, :verify_code_prit_count, :integer, :default => 0
  end

end

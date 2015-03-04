class ChangeCredentialTypeNumberInTechnician < ActiveRecord::Migration
  def change
    change_column :technicians, :credential_type_number, :string
  end
end

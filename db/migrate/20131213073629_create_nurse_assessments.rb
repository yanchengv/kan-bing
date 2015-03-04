class CreateNurseAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :user_id
      t.integer :empirical_value
      t.text :note
      t.string :type  ,:default=>'Assessment'

      t.timestamps
    end
  end
end

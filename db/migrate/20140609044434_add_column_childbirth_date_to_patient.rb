class AddColumnChildbirthDateToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :childbirth_date, :date
  end
end

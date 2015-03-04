class CreateAdviceTypes < ActiveRecord::Migration
  def change
    create_table :advice_types do |t|
      t.string :type_name

      t.timestamps
    end
  end
end

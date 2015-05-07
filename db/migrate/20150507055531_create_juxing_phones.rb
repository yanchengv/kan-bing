class CreateJuxingPhones < ActiveRecord::Migration
  def change
    create_table :juxing_phones do |t|
      t.string :phone
      t.timestamps
    end
  end
end

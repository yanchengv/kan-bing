class CreateExaminedPositions < ActiveRecord::Migration
  def change
    create_table :examined_positions do |t|
      t.string :position

      t.timestamps
    end
  end
end

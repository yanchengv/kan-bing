class ChangeLevelInManager < ActiveRecord::Migration
  def change
    #change_column :managers, :level, 'integer USING CAST(level AS integer)'
    #pg first deploy  uncmment  the upper info  and comment the second
    #change_column :managers, :level,:integer
  end
end

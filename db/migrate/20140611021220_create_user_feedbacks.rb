class CreateUserFeedbacks < ActiveRecord::Migration
  def change
    create_table :user_feedbacks, :id => false  do |t|
      t.integer :id, :limit => 8
      t.integer :user_id , :limit => 8
      #t.string :feedback_title
      t.text :feedback_content

      t.timestamps
    end
    execute "ALTER TABLE user_feedbacks ADD PRIMARY KEY (id);"
  end
end

class AddGraduatedFromToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :graduated_from, :string       #毕业院校
    add_column :doctors, :graduated_at, :date           #毕业时间
    add_column :doctors, :research_paper  , :text       #科研论文
    add_column :doctors, :wechat, :string               #微信账号

    add_column :patients, :wechat, :string
    add_column :technicians, :wechat, :string
    add_column :nurses, :wechat, :string

    add_index :doctors, :wechat
    add_index :patients, :wechat
    add_index :technicians, :wechat
    add_index :nurses, :wechat
  end
end

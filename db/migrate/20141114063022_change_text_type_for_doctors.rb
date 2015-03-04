class ChangeTextTypeForDoctors < ActiveRecord::Migration
  def change
    #把医生几个相关的字段修改为text类型
    change_column :doctors, :expertise, :text #医生擅长
    change_column :doctors, :degree, :text   #学习经历
    change_column :doctors, :rewards, :text  #荣誉奖励
    add_column :doctors, :is_expert, :integer #是否专家
  end
end

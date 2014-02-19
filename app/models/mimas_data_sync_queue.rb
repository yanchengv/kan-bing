#encoding: utf-8
require 'net/http'
class MimasDataSyncQueue < ActiveRecord::Base
  attr_accessible :foreign_key, :table_name, :code, :contents

  #根据院内同步表，扫描表中所有的数据
  def add_data(params)
    table_name=params["table_name"]
    user_name=params['data']['name']
    if table_name=="Patient"
      patient_id=params['data']['id']
      @user=User.new
      pk=@user.create_pk
       User.create(id:pk,name:user_name,patient_id:patient_id,password:123,password_confirmation:123)
    end
    data=params['data']
    @obj=table_name.constantize.new(data)
    if @obj.save
      {data: {success: true}}
    else
      {data: {success: false}}
    end

  end

  #根据院内同步表修改相应表的字段
  def update_data(params)
    table_name=params['table_name']
    contents=params['contents']
    id=params['foreign_key']
    @obj=table_name.constantize
    @obj2=@obj.find_by_id(id)
    flag=@obj2.update_attributes(JSON.parse(contents))
    if  flag
      {data: {success: true}}
    else
      {data: {success: false}}
    end

  end

  #根据院内同步表删除相应的数据
  def destroy_data(params)
    table_name=params['table_name']
    id=params['foreign_key']
    @obj=table_name.constantize
    if @obj.destroy(id)
      {data: {success: true}}
    else
      {data: {success: false}}
    end


  end

end
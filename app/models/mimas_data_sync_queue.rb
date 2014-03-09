#encoding: utf-8
require 'net/http'
class MimasDataSyncQueue < ActiveRecord::Base
  attr_accessible :foreign_key, :table_name, :code, :contents

  #根据院内同步表，扫描表中所有的数据
  def add_data(params)
    data=params['data']
    table_name=params['table_name']
    user_name=data['name']
    pk=data['id']
    #如果tale_name是patient,则需要添加新的User对应Patient.如果传来的Doctor则无需自定义User,院内系统已生成相应user并添加到同步表
    if table_name=='Patient'
      if User.find_by_id(pk)||Patient.find_by_id(pk)
        {data: {success: false, content: '保存的患者ID已存在'}}
      else
        @user=User.new(id: pk, name: user_name, patient_id: pk, password: 'mimas', password_confirmation: 'mimas')
        @obj=table_name.constantize.new(data)
        if @user.save&&@obj.save
          {data: {success: true, content: '保存成功'}}
        else
          {data: {success: false, content: '保存失败'}}
        end
      end
    elsif table_name=='UsReport'
      #添加总索引表的数据
      #data2=params['data2']['data']
      data2=params['data2']
      if InspectionReport.find_by_id(data2['id'])||UsReport.find_by_id(pk)
        {data: {success: false, content: '保存的UsRport已存在'}}
      else
        @obj=table_name.constantize.new(data)
        @obj1=InspectionReport.new(data2)
        if @obj.save&&@obj1.save
          {data: {success: true, content: '保存成功'}}
        else
          {data: {success: false, content: '保存失败'}}
        end
      end

    else
      if table_name.constantize.find_by_id(pk)
        {data: {success: false, content: "保存的#{table_name data['id']}已存在"}}
      else
        @obj=table_name.constantize.new(data)
        if @obj.save
          {data: {success: true, content: '保存成功'}}
        else
          {data: {success: false, content: '保存失败'}}
        end
      end

    end

  end

  #根据院内同步表修改相应表的字段
  def update_data(params)
    table_name=params['table_name']
    contents=params['contents']
    pk=params['foreign_key']
    @obj=table_name.constantize
    @obj2=@obj.find_by_id(pk)
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
#encoding: utf-8
require 'net/http'
class MimasDataSyncQueue < ActiveRecord::Base
  attr_accessible :foreign_key, :table_name, :code, :contents

  #根据院内同步表，扫描表中所有的数据
  def add_data(params)
    data=params['contents']
    table_name=params['table_name']
    pk=data['id']
    #如果tale_name是patient,则需要添加新的User对应Patient.如果传来的Doctor则无需自定义User,院内系统已生成相应user并添加到同步表
    #if table_name=='Patient'
    #  if User.find_by_id(pk)||Patient.find_by_id(pk)
    #    MimasDatasyncResult.create(fk:pk,table_name:table_name,status:'保存失败,患者ID已存在',data_source:"")
    #    {data: {success: false, content: '保存失败,患者ID已存在'}}
    #  else
    #    @user=User.new(id: pk, name: user_name, patient_id: pk, password: 'mimas', password_confirmation: 'mimas')
    #    @obj=table_name.constantize.new(data)
    #    if @user.save&&@obj.save
    #      MimasDatasyncResult.create(fk:@user.id,table_name:'Patient',status:'同步成功',data_source:@user.hospital)
    #      {data: {success: true, content: '保存成功'}}
    #    else
    #      MimasDatasyncResult.create(fk:pk,table_name:table_name,status:'同步成功',data_source:"")
    #      {data: {success: false, content: '保存失败'}}
    #    end
    #  end
    #如果tale_name是User,创建一个新用户，则传过来的{username:'',password:''},code=1
    if table_name=='User'
      user_name=data['name']
      if User.find_by_id(pk)
        MimasDatasyncResult.create(fk:pk,table_name:'User',status:'保存失败,用户ID已存在',data_source:"")
        {data: {success: false, content: '保存失败,患者ID已存在'}}
      else
        #@user=User.new(id: pk, name: user_name, patient_id: pk, password: 'mimas', password_confirmation: 'mimas')
        p JSON.parse(data)
        @obj=table_name.constantize.new(JSON.parse(data))
        if @obj.save
          MimasDatasyncResult.create(fk:@obj.id,table_name:'User',status:'同步成功',data_source:@obj.name)
          {data: {success: true, content: '保存成功'}}
        else
          MimasDatasyncResult.create(fk:pk,table_name:table_name,status:'同步失败',data_source:"")
          {data: {success: false, content: '保存失败'}}
        end
      end
    elsif table_name=='UsReport'
      #添加总索引表的数据
      #data2=params['data2']['data']
      data2=params['data2']
      if InspectionReport.find_by_id(data2['id'])||UsReport.find_by_id(pk)
        MimasDatasyncResult.create(fk:data2['id'],table_name:'UsReport',status:'保存失败,UsRport已存在',data_source:"")
        {data: {success: false, content: '保存失败,UsRport已存在'}}
      else
        @obj=table_name.constantize.new(data)
        @obj1=InspectionReport.new(data2)
        if @obj.save&&@obj1.save
          MimasDatasyncResult.create(fk:@obj.id,table_name:table_name,status:'保存成功',data_source:"")
          MimasDatasyncResult.create(fk:@obj1.id,table_name:'InspectionReport',status:'保存成功',data_source:"")
          {data: {success: true, content: '保存成功'}}
        else
          MimasDatasyncResult.create(fk:data2['id'],table_name:table_name,status:'保存失败',data_source:"")
          MimasDatasyncResult.create(fk:'',table_name:'InspectionReport',status:'保存失败',data_source:"")
          {data: {success: false, content: '保存失败'}}
        end
      end

    else
      if table_name.constantize.find_by_id(pk)
        MimasDatasyncResult.create(fk:pk,table_name:table_name,status:"已存在",data_source:"")
        {data: {success: false, content: "保存的#{table_name data['id']}已存在"}}
      else
        @obj=table_name.constantize.new(data)
        if @obj.save
          MimasDatasyncResult.create(fk:pk,table_name:table_name,status:"保存成功",data_source:"")
          {data: {success: true, content: '保存成功'}}
        else
          MimasDatasyncResult.create(fk:pk,table_name:table_name,status:"保存失败",data_source:"")
          {data: {success: false, content: '保存失败'}}
        end
      end

    end

  end

  #根据院内同步表添加用户User
  def add_user

  end
  #根据院内同步表修改相应表的字段
  def update_data(params)
    table_name=params['table_name']
    contents=params['contents']
    pk=params['foreign_key']
    @obj=table_name.constantize
    @obj2=@obj.find_by_id(pk)
    if @obj2
      flag=@obj2.update_columns(JSON.parse(contents))
      if  flag
        {data: {success: true}}
      else
        {data: {success: false}}
      end
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
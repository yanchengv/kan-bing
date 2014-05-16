#encoding: utf-8
require 'net/http'
class MimasDataSyncQueue < ActiveRecord::Base
  attr_accessible :foreign_key, :table_name, :code, :contents

  #根据院内同步表，扫描表中所有的数据
  def add_data(params)
    data=params['data']
    table_name=params['table_name']
    #如果tale_name是User,创建一个新用户，则传过来的{username:'',password:''},code=1
    #if table_name=='User'
    #  #user_name=data['name']
    #  data0 = params['contents']
    #  pk = data0['id']
    #  if User.find_by_id(pk)
    #    MimasDatasyncResult.create(fk:pk,table_name:'User',status:'保存失败,用户ID已存在',data_source:"")
    #    {data: {success: false, content: '保存失败,患者ID已存在'}}
    #  else
    #    #@user=User.new(id: pk, name: user_name, patient_id: pk, password: 'mimas', password_confirmation: 'mimas')
    #    @obj=table_name.constantize.new(JSON.parse(data0))
    #    if @obj.save
    #      MimasDatasyncResult.create(fk:@obj.id,table_name:'User',status:'同步成功',data_source:@obj.name)
    #      {data: {success: true, content: '保存成功'}}
    #    else
    #      MimasDatasyncResult.create(fk:pk,table_name:table_name,status:'同步失败',data_source:"")
    #      {data: {success: false, content: '保存失败'}}
    #    end
    #  end
    if table_name=='UsReport'
      #添加总索引表的数据
      #data2=params['data2']['data']
      data2=params['data2']
      pk=data['id']
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
    elsif table_name == 'PacsFileRef'
      pk=data["pk"]
      if PacsFileRef.find_by_pk(pk)
        MimasDatasyncResult.create(fk:pk,table_name:table_name,status:"保存失败,PacsFileRef已存在",data_source:"")
        {data: {success: false, content: "保存失败,PacsFileRef已存在"}}
      else
        filesystem = params["filesystem"]
        instance = params["instance"]
        series = params["series"]
        study = params["study"]
        patient = params["patient"]
        PacsFilesystem.create(filesystem) if !PacsFilesystem.find_by_pk(filesystem["pk"])
        PacsPatient.create(patient) if !PacsPatient.find_by_pk(patient["pk"])
        PacsStudy.create(study) if !PacsStudy.find_by_pk(study["pk"])
        PacsSeriese.create(series) if !PacsSeriese.find_by_pk(series["pk"])
        PacsInstance.create(instance) if !PacsInstance.find_by_pk(instance["pk"])
        if PacsFileRef.new(data).save
          MimasDatasyncResult.create(fk:pk,table_name:table_name,status:"保存成功",data_source:"")
          {data: {success: true, content: '保存成功'}}
        else
          MimasDatasyncResult.create(fk:pk,table_name:table_name,status:"保存失败",data_source:"")
          {data: {success: false, content: '保存失败'}}
        end
      end
    else
      pk=data['id']
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
  def add_user(params)
      table_name2=params["table_name2"] #table_name2为Patient或者Doctor
      data=params["data"] #User的数据
      data2=params["data2"] #Patient或者Doctor的数据
      user_id=data["id"]
      obj_id=data2["id"]
      @user=User.new(data)
      @obj=table_name2.constantize.new(data2)
      @user2=User.where("id=?",user_id)
      @obj2=table_name2.constantize.where('id=?',obj_id)
      if  @user2.empty?&&@obj2.empty?
      if @user.save && @obj.save
        {data: {success: true, content: '保存成功'}}
      else
        #User.destroy(user_id)
        #table_name2.constantize.destroy(obj_id)
        {data: {success: false, content: '同步失败'}}
      end
      else
        {data: {success: false, content: '用户ID重复或者用户已存在'}}
      end

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
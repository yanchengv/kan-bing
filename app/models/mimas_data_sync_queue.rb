#encoding: utf-8
require 'net/http'
class MimasDataSyncQueue < ActiveRecord::Base
  attr_accessible :id, :foreign_key, :table_name, :code, :contents, :hospital, :department, :is_processing, :is_finallevel, :file_id, :priority

  #根据院内同步表，扫描表中所有的数据
  def add_data(params)
    data=params['data']
    table_name=params['table_name']
    if table_name=='UsReport'
      #添加总索引表的数据
      #data2=params['data2']['data']
      data2=params['data2']
      pk=data['id']
      #if InspectionReport.find_by_id(data2['id'])||UsReport.find_by_id(pk)
      if InspectionUltrasound.find_by_id(data2['id'])||UsReport.find_by_id(pk)
        MimasDatasyncResult.create(fk:data2['id'],table_name:'UsReport',status:'保存失败,UsRport已存在',data_source:"")
        {data: {success: false, content: '保存失败,UsRport已存在'}}
      else
        @obj=table_name.constantize.new(data)
        #@obj1=InspectionReport.new(data2)
        @obj1=InspectionUltrasound.new(data2)
        if @obj.save&&@obj1.save
          MimasDatasyncResult.create(fk:@obj.id,table_name:table_name,status:'保存成功',data_source:"")
          #MimasDatasyncResult.create(fk:@obj1.id,table_name:'InspectionReport',status:'保存成功',data_source:"")
          MimasDatasyncResult.create(fk:@obj1.id,table_name:'InspectionUltrasound',status:'保存成功',data_source:"")
          {data: {success: true, content: '保存成功'}}
        else
          MimasDatasyncResult.create(fk:data2['id'],table_name:table_name,status:'保存失败',data_source:"")
          #MimasDatasyncResult.create(fk:'',table_name:'InspectionReport',status:'保存失败',data_source:"")
          MimasDatasyncResult.create(fk:'',table_name:'InspectionUltrasound',status:'保存失败',data_source:"")
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
        is_user=@user.save
        is_obj=@obj.save
        #如果同步为医生为其创建患者信息
        if table_name2 == 'Doctor' && (data2["patient_id"].nil? || data2["patient_id"] == '' || data2["patient_id"] == 0)
          @patient = Patient.create(:name => data2["name"], :credential_type => data2["credential_type"], :credential_type_number => data2["credential_type_number"], :gender => data2["gender"],
                                    :birthday => data2["birthday"], :birthplace => data2["birthplace"], :province_id => data2["province_id"], :city_id => data2["city_id"], :hospital_id => data2["hospital_id"],
                                    :department_id => data2["department_id"], :address => data2["address"], :nationality => data2["nationality"], :citizenship => data2["citizenship"], :photo => data2["photo"],
                                    :marriage => data2["marriage"], :mobile_phone => data2["mobile_phone"], :home_phone => data2["home_phone"], :home_address => data2["home_address"], :contact => data2["contact"],
                                    :contact_phone => data2["contact_phone"], :home_postcode => data2["home_postcode"], :email => data2["email"], :introduction => data2["introduction"], :verify_code => data2["verify_code"],
                                    :is_checked => data2["is_checked"], :is_activated => data2["is_activated"], :is_public => data2["is_public"], :spell_code => data2["spell_code"], :province => data2["province_name"])

          @doctor = Doctor.where(" id = ? ", data2["id"]).first
          @doctor.update_attributes(:patient_id => @patient.id)

        end
      if is_user && is_obj
        MimasDatasyncResult.create(fk: obj_id,status:'1',table_name:table_name2,code:4,content:'同步成功')
        {data: {success: true, content: '同步成功'}}
      elsif is_user==true && is_obj==false
        User.destroy(user_id)
        MimasDatasyncResult.create(fk: obj_id,status:'2',table_name:table_name2,code:4,content:"#{table_name2}同步失败")
        {data: {success: false, content: "#{table_name2}同步失败"}}
      elsif is_user==false &&is_obj==true
        table_name2.constantize.destroy(obj_id)
        MimasDatasyncResult.create(fk: obj_id,status:'2',table_name:table_name2,code:4,content:"User同步失败")
        {data: {success: false, content: "User同步失败"}}
      else
        {data: {success: false, content: "#{table_name2}和user都同步失败"}}
      end
      else
        MimasDatasyncResult.create(fk: obj_id,status:'3',table_name:table_name2,code:4,content:'用户ID重复或者用户已存在')
        {data: {success: false, content: '用户ID重复或者用户已存在'}}
      end

  end
  #根据院内同步表修改相应表的字段
  def update_data(params)
    table_name=params['table_name']
    contents=params['contents']
    if contents!=''&& !contents.nil?
    contents=JSON.parse(contents)
    contents.delete('updated_at')
    pk=params['foreign_key']
    @obj=table_name.constantize
    @obj2=@obj.find_by_id(pk)
    if @obj2
      flag=@obj2.update_columns(contents)
      if !contents["email"].nil?
        @obj2.user.update_attribute('email',contents["email"])
      end

      if !contents["mobile_phone"].nil?
        @obj2.user.update_attribute('mobile_phone',contents["mobile_phone"])
      end
      if !contents["credential_type_number"].nil?
        @obj2.user.update_attribute('credential_type_number',contents["credential_type_number"])
      end
      if  flag
        MimasDatasyncResult.create(fk: pk,status:'1',table_name:table_name,code:3,content:'修改成功')
        {data: {success: true}}
      else
        MimasDatasyncResult.create(fk: pk,status:'2',table_name:table_name,code:3,content:'修改失败')
        {data: {success: false}}
      end
    else
      MimasDatasyncResult.create(fk: pk,status:'2',table_name:table_name,code:3,content:'修改失败')
      {data: {success: false}}
    end
    else
      MimasDatasyncResult.create(fk: pk,status:'2',table_name:queue.table_name,code:queue.code,content:'修改失败')
    {data: {success: false}}
      end
  end

  #根据院内同步表删除相应的数据
  def destroy_data(params)
    table_name=params['table_name']
    id=params['foreign_key']
    @obj=table_name.constantize
    @objs=@obj.where('id=?',id)
    if @objs.empty?
      MimasDatasyncResult.create(fk: id,status:'1',table_name:table_name,code:3,content:'公网无此用户')
      {data: {success: false,contents:'公网无此用户'}}
    else
      if @obj.destroy(id)
        MimasDatasyncResult.create(fk: id,status:'1',table_name:table_name,code:3,content:'删除成功')
        {data: {success: true,contents:'成功'}}
      else
        MimasDatasyncResult.create(fk: id,status:'1',table_name:table_name,code:3,content:'删除失败')
        {data: {success: false,contents:'失败'}}
      end
    end




  end

end
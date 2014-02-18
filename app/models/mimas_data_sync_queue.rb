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
  include HTTParty
  CISHOST=Settings.cis
  CISURL='http://'+CISHOST.name+':'+CISHOST.port.to_s+'/'

  def scan
    datas=MimasDataSyncQueue.all
    if  !datas.nil?
      datas.each do |data|
        code=data.code
        result=case code
                 #code事件类型:1=添加;2=删除;3=修改
                 when 1
                   insert_data data
                 when 2
                   des_data data
                 when 3
                   chan_data data
                 else
                   "无type所属的类型操作"
               end
      end
    end
  end

  #公网向院内同步添加的数据
  def insert_data queue
    path='mimas_data_sync_queue/create'
    table_name=queue.table_name
    table_name=table_name.constantize
    @obj=table_name.find_by_id(queue.foreign_key)
    params={:table_name => table_name, :data => @obj.as_json(:except => [:created_at, :updated_at])}
    params= {:body => params}
    response= HTTParty.post(CISURL+path, params)
    flag=response['data']['success']
    if flag
      MimasDataSyncQueue.destroy(queue.id)
    end
  end

  #公网向院内同步的删除数据
  def des_data queue
    path='mimas_data_sync_queue/destroy'
    params=queue.as_json
    params={:body => params}
    response=self.class.post(CISURL+path, params)
    flag=response['data']['success']
    if flag
      MimasDataSyncQueue.destroy(queue.id)
    end
  end

  #公网向院内同步修改的数据
  def chan_data queue
    path='mimas_data_sync_queue/change'
    params=queue.as_json
    params={:body => params}
    response=self.class.post(CISURL+path, params)
    flag=response['data']['success']
    if flag
      MimasDataSyncQueue.destroy(queue.id)
    end
  end
end
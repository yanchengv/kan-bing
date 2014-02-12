#encoding: utf-8
require 'net/http'
class MimasDataSyncQueue < ActiveRecord::Base
  attr_accessible :foreign_key, :table_name, :code, :contents

  #扫描表中所有的数据
  def add_data(params)
    table_name=params["table_name"]
    data=params['data']
    @obj=table_name.constantize.new(data)
     if @obj.save
       {data:{success:true}}
     else
       {data:{success:false}}
     end

  end

  def change_data(data)

  end
  def delte_data(data)

  end
end


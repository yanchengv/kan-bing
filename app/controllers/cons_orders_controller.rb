# encoding: utf-8
class ConsOrdersController < ApplicationController
  def new
    @cons_order = ConsOrder.new
  end

  def index

  end

  def create
    para = {}
    para[:owner_id] = current_user.id
    para[:consignee_id] = params[:consignee_id]
    para[:reason] = params[:cons_order][:reason]
    if !current_user.is_doctor?
      para[:status] = 'agreed'
      para[:status_description] = '主治医生与患者已确认,待付款'
    else
      para[:status] = 'submit'
      para[:status_description] = '申请已提交，待确认'
    end
    @cons_order= current_user.cons_orders.build(para)
    if @cons_order.save
=begin
      if !params[:doclistfororder].nil?
        #排除doclist里面错误重复选择医生
        params[:doclistfororder].each do |doctormemberid|
          if doctormemberid != @cons_order.owner_id && doctormemberid != @cons_order.consignee_id
            @doctor_list = DocListForOrder.create()
            @doctor_list.cons_order= @cons_order
            @doctor_list.docmember_id = doctormemberid
            @doctor_list.status = false
            @doctor_list.save
          end
        end
      end
=end
      flash[:success] = "申请创建成功"
      redirect_back_or home_path
    else
      render 'new'
    end
  end
  def agree
    @order = ConsOrder.find(params[:id])
    @order.agree()
=begin
    if @order.doc_list_for_orders.empty?
      @order.status = 'waited'
      @order.status_description = '所有医生已确认,待付款'
      @order.save()
    end
=end
    redirect_back_or home_path
  end
  def disagree
    ConsOrder.find(params[:id]).disagree()
    redirect_back_or home_path
  end
=begin
  def agreetojoin
    ConsOrder.find(params[:id]).agreetojoin(current_user.id)
    redirect_back_or home_path
  end
=end
  def pay
    ConsOrder.find(params[:id]).pay()
    redirect_back_or home_path
  end

  def show
    @order = ConsOrder.find(params[:id])
  end

end

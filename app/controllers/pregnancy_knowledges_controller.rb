class PregnancyKnowledgesController < ApplicationController
  layout 'mobile_app'
  def index
    parent_id = params[:parent_id]
    @contents = PregnancyKnowledge.where(parent_id:parent_id).order("CAST(content as SIGNED) ")#用于mysql数据库
    #@contents = PregnancyKnowledge.where(parent_id:parent_id).order("CAST(content as int) ")#用于pg数据库
    @first_week=nil
    if !@contents.nil? && @contents.length>0
      @first_week = PregnancyKnowledge.where(parent_id:@contents.first.id)
    end
    render 'pregnancy_knowledges/index'
  end

  def show_parent
    parent_id = params[:parent_id]
    @contents = PregnancyKnowledge.where(parent_id:parent_id).order('id')#.order("CAST(content as SIGNED)")
    #render partial: 'pregnancy_knowledges/parent_page'
    render json:{success:true,data:@contents.as_json(:only => [:id,:title])}
  end

  def show_child
    parent_id = params[:parent_id]
    @title = PregnancyKnowledge.find_by_id(parent_id)
    @contents = PregnancyKnowledge.where(parent_id:parent_id)
    render partial: 'pregnancy_knowledges/child_page'
  end

  def pregnancy_app
   render json:{success:true,data:'http://kanbing365.com/pregnancy_knowledges/index'}
  end
end

class PregnancyKnowledgesController < ApplicationController
  layout 'mobile_app'
  def index
    parent_id = params[:parent_id]
    @contents = PregnancyKnowledge.where(parent_id:parent_id)
    @first_week = PregnancyKnowledge.where(parent_id:@contents.first.id)
    render 'pregnancy_knowledges/index'
  end

  def show_parent
    parent_id = params[:parent_id]
    @contents = PregnancyKnowledge.where(parent_id:parent_id)
    render partial: 'pregnancy_knowledges/parent_page'
  end

  def show_child
    parent_id = params[:parent_id]
    @contents = PregnancyKnowledge.where(parent_id:parent_id)
    render partial: 'pregnancy_knowledges/child_page'
  end

  def pregnancy_app
   render json:{success:true,data:'http://kanbing365.com/pregnancy_knowledges/index'}
  end
end

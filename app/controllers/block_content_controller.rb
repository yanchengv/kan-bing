class BlockContentController < ApplicationController
  layout "center"
  def show
      id=params[:content_id]
      @block_content=BlockContent.where(id:id).first#.order(create_date: :asc)
      @page_block=PageBlock.where(id:@block_content.block_id).first
      #网站的风格样式
      host=request.host
      style=HomePage.new.get_style host
      render template:'block_content/show',layout:style and return
  end
  def list
    page_block_id=params[:page_block]
    @page_block=PageBlock.where(id:page_block_id).first
    @block_contents=BlockContent.where(block_id:page_block_id).order(create_date: :desc)
    #网站的风格样式
    host=request.host
    style=HomePage.new.get_style host
    render template:'block_content/list',layout:style and return
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def block_content_params
    params.permit(:block_name, :title, :content, :url, :block_type, :create_date, :block_id)
    # params.require(:page_block).permit(:id, :name, :content, :created_id, :created_name, :updated_id, :updated_name, :hospital_id, :hospital_name, :department_id, :department_name, :page_id, :position, :is_show,:block_type)
  end
end

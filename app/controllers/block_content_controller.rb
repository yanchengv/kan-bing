class BlockContentController < ApplicationController
  def show
      id=params[:content_id]
      @block_content=BlockContent.where(id:id).first#.order(create_date: :asc)
      @page_block=PageBlock.where(id:@block_content.block_id).first
      p  @page_block.id
      render template:'block_content/show'
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def block_content_params
    params.permit(:block_name, :title, :content, :url, :block_type, :create_date, :block_id)
  end
end

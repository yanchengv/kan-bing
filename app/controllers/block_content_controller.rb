class BlockContentController < ApplicationController
  def show
      id=params[:content_id]
      @block_content=BlockContent.where(id:id).only(:block_name, :title, :content).first#.order(create_date: :asc)
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def block_content_params
    params.permit(:block_name, :title, :content, :url, :block_type, :create_date, :block_id)
  end
end

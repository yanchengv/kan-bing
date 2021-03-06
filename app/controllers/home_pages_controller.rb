class HomePagesController < ApplicationController
  # before_action :set_home_page, only: [:show, :edit, :update, :destroy]
  # skip_before_filter :verify_authenticity_token, only: [:upload]
  layout "center", :only => :show_content
  def show_content
    link_url = params[:link_url]
    @home_page = HomePage.where(:link_url => link_url).first
    #网站的风格样式
    host=request.host
    style=HomePage.new.get_style host
    render 'home_menus/show'
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_home_page
    @home_page = HomePage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def home_page_params
    params.permit(:id,:home_menu_id,:name,:content,:hospital_id,:department_id,:position,:link_url)
  end
end


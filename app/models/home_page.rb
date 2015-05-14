class HomePage < ActiveRecord::Base
  belongs_to :home_menu, :dependent => :destroy, :foreign_key => :home_menu_id
  attr_accessible :home_menu_id, :name, :content, :hospital_id, :department_id, :position, :link_url, :redirect_url


  #根据域名获取网站的风格样式:例如host=www.kanbing365.com
  def get_style host
    style='center' #为默认风格
    @domain=Domain.where(name:host).first
    if !@domain.nil?
      style=@domain.style
    end
    style
  end

end

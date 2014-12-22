module CenterHelper
  def get_logo host
       @domains=Domain.where(name:host)
        if !@domains.empty?
             @logo=@domains.first.logo_url
        else
          @logo="365logo.png"
        end
       return  @logo
  end

  def get_menus_by_host host
    @domain=Domain.where(name: host).first
    if @domain
      str = ''
      home_menus = HomeMenu.where('hospital_id=? and department_id=? and show_in_menu = ? and (parent_id = 0 or parent_id = null)', @domain.hospital_id, @domain.department_id, true).order(depth: :asc)
      str << get_navigations(home_menus)
      return str
    else
      return ''
    end
  end

  def get_navigations(home_menus)
    str = ''
      home_menus.each do |hm|
        str << "<li class='current'><a href='/home_menu/show/#{hm.id}'>#{hm.name}</a>"
        if !hm.child_menus.nil? && !hm.child_menus.empty?
          str << "<ul>"
          str << get_navigations(hm.child_menus)
          str << "</ul>"
        end
        str << "</li>"
      end
      return str
  end
end

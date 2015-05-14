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
    # @domain=Domain.where(name: host).first
    @domain=Domain.where(name: 'yuquan.kanbing365.com').first
    if @domain
      str = ''
      home_menus = HomeMenu.where('hospital_id=? and department_id=? and show_in_menu = ? and parent_id = ?', @domain.hospital_id, @domain.department_id, true, 0).order(depth: :asc)
      str << get_navigations(home_menus)
      return str
    else
      return ''
    end
  end

  def get_navigations(home_menus)
    str = ''
      home_menus.each do |hm|
        if !hm.redirect_url.nil? && hm.redirect_url != ''
          str << "<li class='current'><a href='#{hm.redirect_url}'>#{hm.name}</a>"
        else
          if hm.home_page && !hm.home_page.link_url.nil? && hm.home_page.link_url != ''
            str << "<li class='current'><a href='/center/#{hm.home_page.link_url}'>#{hm.name}</a>"
          else
            str << "<li class='current'><a href='/home_menu/show/#{hm.id}'>#{hm.name}</a>"
          end
        end

        if !hm.child_menus.where(:show_in_menu => true).nil? && !hm.child_menus.where(:show_in_menu => true).empty?
          str << "<ul>"
          str << get_navigations(hm.child_menus.where(:show_in_menu => true))
          str << "</ul>"
        end
        str << "</li>"
      end
      return str
  end
end

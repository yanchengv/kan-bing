module UsersHelper
  def is_doctor
    if  current_user.doctor.nil?
      return false

    else
      return true
    end

  end

  def is_patient
    if current_user.patient.nil?
      return false
    else
      return true
    end
  end

  def my_photo
    if current_user
      if !current_user.doctor.nil?
        photo=current_user.doctor.photo
      elsif !current_user.patient.nil?
        photo=current_user.patient.photo
      end
      if photo.nil?||photo==''
        photo='/default.png'
      else
        photo= default_access_url_prefix_with(photo)
      end
      return photo
    end
  end

  def my_photo_aliyun
    if current_user
      if !current_user.doctor.nil?
        photo=current_user.doctor.photo
      elsif !current_user.patient.nil?
        photo=current_user.patient.photo
      end
      if photo.nil?||photo==''
        photo='/default.png'
      else
        photo= default_access_url_prefix + photo
      end
      return photo
    end
  end
  #根据域名获取导航
  def get_home_menus
    puts "==============host==#{request.host}"
    host=request.host
    @domain=Domain.where(name: host).first
    if @domain
      hospital_id= @domain.hospital_id
      department_id=@domain.department_id
    end
    if !hospital_id.nil? || !department_id.nil?
      return HomeMenu.where('hospital_id=? AND department_id=? AND show_in_menu=?', hospital_id, department_id, true).order(depth: :asc)
    else
      return nil
    end
  end
end

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
        photo=Settings.pic+photo
      end
      return photo
    end
  end
end

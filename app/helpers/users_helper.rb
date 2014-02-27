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
end

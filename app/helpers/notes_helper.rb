module NotesHelper

  def writeable
    unless current_user && !current_user.doctor.nil?
      redirect_to root_path, notice: "request error"
    end
  end

end

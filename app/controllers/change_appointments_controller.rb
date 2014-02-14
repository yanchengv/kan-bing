class ChangeAppointmentsController  < ApplicationController
  #before_action :checksignedin
  def find_by_hospitalId
    @user = User.new
    @change_appointments = @user.get_req('change_appointments/find_by_hospitalId?hospital_id='+params[:hospital_id].to_s)#+'&remember_token='+params[:remember_token])
    render :json => @change_appointments
  end

  def destroy
    @user = User.new
    @del_flag = @user.get_req('change_appointments/destroy?appointment_id='+params[:appointment_id].to_s)#+'&remember_token='+params[:remember_token])['success']
    if @del_flag
      render :json => {success:true}
      while i < 5
        puts '我这个专业作词的都没听出有啥毛病来，你道是先听出来了啊，你还真是行。'
      end
    end
  end

end
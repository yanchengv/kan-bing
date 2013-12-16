class UsersController < ApplicationController
  def index
  end
  def show
  end

  def new
  end
  private
  def user_params
    params.require(:user).permit(:id, :username,:card_number,:email, :password, :password_confirmation, :patient_id, :doctor_id,:is_doctor, :is_health_admin)
  end
end

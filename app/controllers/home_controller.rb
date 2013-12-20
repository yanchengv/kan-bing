class HomeController < ApplicationController
  def index
    puts 'baekhyun'
    if signed_in?
      if  !current_user['doctor_id'].nil?
        @user0 = User.new
        @user1 = @user0.get_req('find_by_id?doctor_id='+ current_user['doctor_id'].to_s)['data']
        puts @user1['name']
      elsif !current_user['patient_id'].nil?
        @user0 = User.new
        @user1 = @user0.get_req('find_by_id?patient_id='+current_user['patient_id'].to_s)['data']
        puts @user1['name']
      end
    end
  end
  def new

  end
  def about
  end

  def contact
  end
end
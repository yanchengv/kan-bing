class HomeController < ApplicationController
  def index
    @user = User.new
    @doctor = @user.get_req('find_all_doctor')['data']
    puts @doctor.length
    puts 'baekhyun'
    if signed_in?
      #if  !current_user['doctor_id'].nil?
      #  @user0 = User.new
      #  @user1 = @user0.get_req('find_by_id?doctor_id='+ current_user['doctor_id'].to_s)['data']
      #  puts @user1['name']
      #elsif !current_user['patient_id'].nil?
      #  @user0 = User.new
      #  @user1 = @user0.get_req('find_by_id?patient_id='+current_user['patient_id'].to_s)['data']
      #  puts @user1['name']
      #end
      @user0 = User.new
      user = @user0.get_req('find_by_id?user_id='+current_user['id'].to_s)['data']
      if !user['doctor'].nil?
        @user1 = user['doctor']
        puts @user1['name']
      elsif !user['patient'].nil?
        @user1 = user['patient']
        puts @user1['name']
      end
      @photos = user['photos']
    end
  end
  def new

  end
  def about
  end

  def contact
  end
end
class HomeController < ApplicationController
  def index
    if signed_in?
      @user0 = User.new
      user = @user0.get_req('users/find_by_id?user_id='+current_user['id'].to_s)['data']
      puts user
      if !user['doctor'].nil?
        @user1 = user['doctor']
        puts @user1['name']
      elsif !user['patient'].nil?
        @user1 = user['patient']
        puts @user1['name']
      end
      @photos = user['photos']
    else
      @user = User.new
      @doctors1 = @user.get_req('doctors/find_all_doctor')['data']
    end
  end
  def new

  end
  def about
  end

  def contact
  end
end
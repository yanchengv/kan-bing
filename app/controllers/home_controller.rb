class HomeController < ApplicationController
  caches_page :show
  caches_action :home
  def index
      @user = User.new
      @doctors1 = @user.get_req('doctors/find_all_doctor')['data']
      @doctor = @doctors1[0]
      @num = @doctors1.length-1

  end
  def new

  end
  def about
  end

  def contact
  end
  def home
      @user0 = User.new
      user = @user0.get_req('users/find_by_id?user_id='+current_user['id'].to_s)['data']
      if !user['doctor'].nil?
        @user1 = user['doctor']
      elsif !user['patient'].nil?
        @user1 = user['patient']
      end
      @photos = user['photos']
  end
end
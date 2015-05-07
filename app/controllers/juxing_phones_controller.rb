#encoding:utf-8
#wifi保存用戶
class JuxingPhonesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def add
      phone=params[:phone]
      @flag=false
      @phone=JuxingPhones.where(phone:phone)
      if  @phone.empty?
        @juxing_phone=JuxingPhones.new(phone:phone)
        if @juxing_phone.save
          @flag=true
        end

      end

    render json:@flag
  end

  def show
    @juxing_phones=JuxingPhones.all

  end
end


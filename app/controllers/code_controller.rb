class CodeController < ActionController::Base
  #def index
  #  session[:noisy_image] = NoisyImage.new(4) #生成一个有4字符的图片
  #  session[:code] = session[:noisy_image].code
  #end
  def code_image
    @noisy = NoisyImage.new(4) #生成一个有4字符的图片
    @code=""
    @code.insert(0, @noisy.code[2])
    @code.insert(1, @noisy.code[7])
    @code.insert(2, @noisy.code[12])
    @code.insert(3, @noisy.code[17])
    session[:code] = @code
    image = @noisy.code_image
    send_data image, :type => 'image/jpeg', :disposition => 'inline'
  end
end
module CenterHelper
  def get_logo host
       @domains=Domain.where(name:host)
        if !@domains.empty?
             @logo=@domains.first.logo_url
        else
          @logo="365logo.png"
        end
       return  @logo
  end
end

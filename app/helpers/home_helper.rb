#encoding:utf-8
module HomeHelper
  def hosname_str_sub(hosp_name)
    if hosp_name.include?("医院")
      if hosp_name.length< 11
        index = hosp_name.index("院")
        index += 1
        return hosp_name[0,index]
      else
        return hosp_name[0,9]
      end
    else
      return hosp_name[0,9]
   end

  end

  def  short_desc(descrition)
    if !descrition.nil?

      return sanitize  @hospital.description.truncate(100)

    else
      return "暂无简介"
    end
  end


  def  long_desc(descrition)
    if !descrition.nil?

      return sanitize  @hospital.description

    else
      return "暂无简介"
    end


  end


end

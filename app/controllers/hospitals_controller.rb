class HospitalsController < ApplicationController
  before_action :checksignedin, only:[:find]
  before_action :set_hospital, only: [:show, :edit, :update, :destroy]
  #before_action :set_hospital_by_name ,only:[:show]
  respond_to :js
  def index
    #@start = params[:start]
    #@limit = params[:limit]
    #if params[:department]
    #  @hospitals = Hospital.where(params[:hospital])
    #
    #else
    #  @hospitals = Hospital.all
    #end
    #total = @hospitals.count
    #hospitals = @hospitals.limit(@limit).offset(@start)
    #
    #@json = '{"success":true,"total":' << "#{total}" << ',"hospitals":' << hospitals.to_json << ' }'
    #respond_to do |format|
    #  format.json { render :json =>  @json}
    #end
  end

  def new
    @hospital = Hospital.new
  end
  def edit
  end

  def show

  end

  def create
    @hospital = Hospital.new(hospital_params)
    respond_to do |format|
      if @hospital.save
        format.json { render json: {success: true, hospital: @hospital} }
      else
        format.json { render json: {success: false, errors: @hospital.errors} }
      end
    end
  end

  def update
    respond_to do |format|
      if @hospital.update(hospital_params)
        format.html { redirect_to @hospital, notice: 'Hospital was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hospital.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

#############################################Minma中接口#############################################
  def find
    @hospital = Hospital.find(params[:hospital_id])
    render :json => @hospital
  end

  private
  def set_hospital
     @hospital = Hospital.find(params[:id])
  end

  def set_hospital_by_name

    name = params[:name].strip
    q =  "%" << name.to_s << "%"
    @hospital = Hospital.where("name like ?",q).first
    @hospital.expire_second_level_cache

    @hospital.write_second_level_cache
  end

  def hospital_params
    params.require(:hospital).permit(:id, :name, :short_name, :spell_code, :address, :phone, :description, :rank, :province_id,
                                     :province_name,
                                     :city_id,
                                     :city_name,
                                     :key_departments,
                                     :operation_mode,
                                     :email,
                                     :hospital_site,
                                     :fax_number)
  end

end

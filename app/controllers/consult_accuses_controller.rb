class ConsultAccusesController < ApplicationController
  before_action :set_consult_accuse, only: [:show, :edit, :update, :destroy]

  # GET /consult_accuses
  # GET /consult_accuses.json
  def index
    @consult_accuses = ConsultAccuse.all
  end

  # GET /consult_accuses/1
  # GET /consult_accuses/1.json
  def show
  end

  # GET /consult_accuses/new
  def new
    @consult_accuse = ConsultAccuse.new
  end

  # GET /consult_accuses/1/edit
  def edit
  end

  # POST /consult_accuses
  # POST /consult_accuses.json
  def create
    @consult_accuse = ConsultAccuse.new(consult_accuse_params)
    if current_user
      @consult_accuse.created_by = current_user.id
      if @consult_accuse.save
        render :json => {:success => true}
      else
        render :json => {:success => false, :error => '举报提交失败！'}
      end
    else
      render :json => {:success => false, :error => '登录后才能进行举报！'}
    end

    #respond_to do |format|
    #  if @consult_accuse.save
    #    format.html { redirect_to @consult_accuse, notice: 'ConsultAccuse was successfully created.' }
    #    format.json { render :show, status: :created, location: @consult_accuse }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @consult_accuse.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /consult_accuses/1
  # PATCH/PUT /consult_accuses/1.json
  def update
    respond_to do |format|
      if @consult_accuse.update(consult_accuse_params)
        format.html { redirect_to @consult_accuse, notice: 'ConsultAccuse was successfully updated.' }
        format.json { render :show, status: :ok, location: @consult_accuse }
      else
        format.html { render :edit }
        format.json { render json: @consult_accuse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consult_accuses/1
  # DELETE /consult_accuses/1.json
  def destroy
    @consult_accuse.destroy
    respond_to do |format|
      format.html { redirect_to consult_accuses_url, notice: 'ConsultAccuse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_consult_accuse
    @consult_accuse = ConsultAccuse.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def consult_accuse_params
    params.require(:consult_accuse).permit(:reason, :created_by, :question_id, :result_id)
  end
end


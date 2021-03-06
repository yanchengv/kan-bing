class NoteAdmiredsController < ApplicationController
  before_action :set_note_admired, only: [:show, :edit, :update, :destroy]

  # GET /note_admireds
  # GET /note_admireds.json
  def index
    @note_admireds = NoteAdmired.all
  end

  # GET /note_admireds/1
  # GET /note_admireds/1.json
  def show
  end

  # GET /note_admireds/new
  def new
    @note_admired = NoteAdmired.new
  end

  # GET /note_admireds/1/edit
  def edit
  end

  # POST /note_admireds
  # POST /note_admireds.json
  def create
    @note_admired = NoteAdmired.new(note_admired_params)
    @note_admireds = NoteAdmired.where(:user_id => @note_admired.user_id, :note_id => @note_admired.note_id)
    @note = Note.find(@note_admired.note_id)
    if @note_admireds.empty?
      if @note_admired.save
        render :json => {:success => true, :count => @note.nil? ? 0 : @note.note_admireds.count }
      else
        render :json => {:success => false, :errors => "点赞操作失败！"}
      end
    else
      render :json => {:success => false, :errors => "不能重复点赞！"}
    end
  end

  # PATCH/PUT /note_admireds/1
  # PATCH/PUT /note_admireds/1.json
  def update
    respond_to do |format|
      if @note_admired.update(note_admired_params)
        format.html { redirect_to @note_admired, notice: 'NoteAdmired was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_admired }
      else
        format.html { render :edit }
        format.json { render json: @note_admired.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_admireds/1
  # DELETE /note_admireds/1.json
  def destroy
    @note_admired.destroy
    respond_to do |format|
      format.html { redirect_to note_admireds_url, notice: 'NoteAdmired was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  #取消点赞
  def del_admired
    if params[:user_id] && params[:note_id]
      @note = Note.find(params[:note_id])
      @note_admireds = NoteAdmired.where(:user_id => params[:user_id], :note_id => params[:note_id])
      @note_admireds.delete_all
      render :json => {:success => true, :count => @note.nil? ? 0 : @note.note_admireds.count}
    else
      render :json => {:success => false, :errors => "点赞取消失败！"}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note_admired
    @note_admired = NoteAdmired.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_admired_params
    params.require(:note_admired).permit(:user_id, :note_id)
  end
end

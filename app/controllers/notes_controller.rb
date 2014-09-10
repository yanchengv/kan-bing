class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    if current_user
      if current_user.doctor_id
        if params[:note]
          notes = current_user.doctor.notes.where(params[:note]).group(:is_top, :created_at)
        else
          notes = current_user.doctor.notes.group(:is_top, :created_at)
        end

      end
    end
    @notes = notes.paginate(:per_page => 15, :page => params[:page])
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
    if current_user
      @note.created_by_id = current_user.id
      @note.created_by = current_user.name
      if current_user.doctor_id
        @note.doctor_id = current_user.doctor_id
      end
    end
    @note.save

  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: '文章发表成功！' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: '文章更新成功！' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def batch_del
    if params[:ids]
      @notes = Note.where("id in #{params[:ids]}")
      @notes.delete_all
    end
    redirect_to action: 'index'
    #respond_to do |format|
    #  format.html { redirect_to notes_url, notice: 'Notes was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:head, :subhead, :content, :archtype, :deleted_at, :is_public, :is_top, :is_allow_comment, :is_visible, :who_deleted, :created_by, :created_by_id, :update_by, :update_by_id, :audit_by, :audit_time, :pubstatus, :excellent, :indexpage, :site, :pageview, :replies_count)
    end
end

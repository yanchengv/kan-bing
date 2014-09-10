class NoteTypesController < ApplicationController
  before_action :set_note_type, only: [:show, :edit, :update, :destroy]

  # GET /note_types
  # GET /note_types.json
  def index
    if current_user
      if current_user.doctor_id
        note_types = current_user.doctor.note_types
      end
    end
    @note_types = note_types.paginate(:per_page => 15, :page => params[:page])
    render "/notes/note_type_index"
  end

  # GET /note_types/1
  # GET /note_types/1.json
  def show
  end

  # GET /note_types/new
  def new
    @note_type = NoteType.new
  end

  # GET /note_types/1/edit
  def edit
  end

  # POST /note_types
  # POST /note_types.json
  def create
    @note_type = NoteType.new(note_type_params)

    if @note_type.save
      redirect_to action: 'index'
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @note_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_types/1
  # PATCH/PUT /note_types/1.json
  def update

    if @note_type.update(note_type_params)
      redirect_to action: 'index'
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @note_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_types/1
  # DELETE /note_types/1.json
  def destroy
    @note_type.destroy
    respond_to do |format|
      format.html { redirect_to note_types_url, notice: 'NoteType was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note_type
    @note_type = NoteType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_type_params
    params.require(:note_type).permit(:name, :create_by_id, :notes_count, :source_by)
  end
end

class NoteAdmiredAdmiredsController < ApplicationController
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

    respond_to do |format|
      if @note_admired.save
        format.html { redirect_to @note_admired, notice: 'NoteAdmired was successfully created.' }
        format.json { render :show, status: :created, location: @note_admired }
      else
        format.html { render :new }
        format.json { render json: @note_admired.errors, status: :unprocessable_entity }
      end
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

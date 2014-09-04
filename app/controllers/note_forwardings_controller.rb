class NoteForwardingsController < ApplicationController
  before_action :set_note_forwarding, only: [:show, :edit, :update, :destroy]

  # GET /note_forwardings
  # GET /note_forwardings.json
  def index
    @note_forwardings = NoteForwarding.all
  end

  # GET /note_forwardings/1
  # GET /note_forwardings/1.json
  def show
  end

  # GET /note_forwardings/new
  def new
    @note_forwarding = NoteForwarding.new
  end

  # GET /note_forwardings/1/edit
  def edit
  end

  # POST /note_forwardings
  # POST /note_forwardings.json
  def create
    @note_forwarding = NoteForwarding.new(note_forwarding_params)

    respond_to do |format|
      if @note_forwarding.save
        format.html { redirect_to @note_forwarding, notice: 'NoteForwarding was successfully created.' }
        format.json { render :show, status: :created, location: @note_forwarding }
      else
        format.html { render :new }
        format.json { render json: @note_forwarding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_forwardings/1
  # PATCH/PUT /note_forwardings/1.json
  def update
    respond_to do |format|
      if @note_forwarding.update(note_forwarding_params)
        format.html { redirect_to @note_forwarding, notice: 'NoteForwarding was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_forwarding }
      else
        format.html { render :edit }
        format.json { render json: @note_forwarding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_forwardings/1
  # DELETE /note_forwardings/1.json
  def destroy
    @note_forwarding.destroy
    respond_to do |format|
      format.html { redirect_to note_forwardings_url, notice: 'NoteForwarding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note_forwarding
    @note_forwarding = NoteForwarding.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_forwarding_params
    params.require(:note_forwarding).permit(:user_id, :note_id)
  end
end


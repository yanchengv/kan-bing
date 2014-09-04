class NoteCommentsController < ApplicationController
  before_action :set_note_comment, only: [:show, :edit, :update, :destroy]

  # GET /note_comments
  # GET /note_comments.json
  def index
    @note_comments = NoteComment.all
  end

  # GET /note_comments/1
  # GET /note_comments/1.json
  def show
  end

  # GET /note_comments/new
  def new
    @note_comment = NoteComment.new
  end

  # GET /note_comments/1/edit
  def edit
  end

  # POST /note_comments
  # POST /note_comments.json
  def create
    @note_comment = NoteComment.new(note_comment_params)

    respond_to do |format|
      if @note_comment.save
        format.html { redirect_to @note_comment, notice: 'NoteComment was successfully created.' }
        format.json { render :show, status: :created, location: @note_comment }
      else
        format.html { render :new }
        format.json { render json: @note_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_comments/1
  # PATCH/PUT /note_comments/1.json
  def update
    respond_to do |format|
      if @note_comment.update(note_comment_params)
        format.html { redirect_to @note_comment, notice: 'NoteComment was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_comment }
      else
        format.html { render :edit }
        format.json { render json: @note_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_comments/1
  # DELETE /note_comments/1.json
  def destroy
    @note_comment.destroy
    respond_to do |format|
      format.html { redirect_to note_comments_url, notice: 'NoteComment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note_comment
    @note_comment = NoteComment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_comment_params
    params.require(:note_comment).permit(:user_id, :note_id, :name, :comment)
  end
end


class ConsultQuestionsController < ApplicationController
  before_action :set_consult_question, only: [:show, :edit, :update, :destroy]

  # GET /consult_questions
  # GET /consult_questions.json
  def index
    @consult_questions = ConsultQuestion.all
  end

  # GET /consult_questions/1
  # GET /consult_questions/1.json
  def show
  end

  # GET /consult_questions/new
  def new
    @consult_question = ConsultQuestion.new
  end

  # GET /consult_questions/1/edit
  def edit
  end

  # POST /consult_questions
  # POST /consult_questions.json
  def create
    @consult_question = ConsultQuestion.new(consult_question_params)

    respond_to do |format|
      if @consult_question.save
        format.html { redirect_to @consult_question, notice: 'ConsultQuestion was successfully created.' }
        format.json { render :show, status: :created, location: @consult_question }
      else
        format.html { render :new }
        format.json { render json: @consult_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consult_questions/1
  # PATCH/PUT /consult_questions/1.json
  def update
    respond_to do |format|
      if @consult_question.update(consult_question_params)
        format.html { redirect_to @consult_question, notice: 'ConsultQuestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @consult_question }
      else
        format.html { render :edit }
        format.json { render json: @consult_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consult_questions/1
  # DELETE /consult_questions/1.json
  def destroy
    @consult_question.destroy
    respond_to do |format|
      format.html { redirect_to consult_questions_url, notice: 'ConsultQuestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_consult_question
    @consult_question = ConsultQuestion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def consult_question_params
    params.require(:consult_question).permit(:consult_content, :consulting_by, :created_by, :consult_identity)
  end
end


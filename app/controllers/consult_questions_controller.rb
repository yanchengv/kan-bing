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
    if current_user
      @consult_question = ConsultQuestion.new(consult_question_params)
      @consult_question.created_by = current_user.id
      if current_user.doctor_id
        @consult_question.consult_identity = 0  #医生
      end
      if current_user.nurse_id
        @consult_question.consult_identity = 2  #护士
      end
      if current_user.patient_id
        @consult_question.consult_identity = 1  #患者
      end

      if @consult_question.save
        render json: {:success => true, :error => '保存成功！'}
      else
        render json: {:success => true, :error => '信息有误，请确认！'}
      end
    else
      render json: {:success => false, :error => '用户需登录才能咨询！'}
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


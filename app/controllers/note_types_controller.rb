class NoteTypesController < ApplicationController
  before_action :set_note_type, only: [:show, :edit, :update, :destroy]

  # GET /note_types
  # GET /note_types.json
  def index
    if current_user
      note_types = current_user.note_types
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
    @note_types = NoteType.where(:name => @note_type.name, :create_by_id => @note_type.create_by_id)
    if @note_types.empty?
      if @note_type.save
        redirect_to action: 'index'
      else
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @note_type.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def async_create
    if current_user && params[:tag_name] && params[:tag_name] != ''
      @note_types = NoteType.where(:name => params[:tag_name], :create_by_id => current_user.id)
      if @note_types.empty?
        if NoteType.create(:name => params[:tag_name], :create_by_id => current_user.id, :source_by => 1)
          render json: {:success => true, :note_types => current_user.note_types}
        else
          render json: {:success => false, :errors => '类型添加失败！'}
        end
      else
        render json: {:success => false, :errors => '文章类型已存在！'}
      end
    else
      render json: {:success => false, :errors => '没有登录或标签名为空！'}
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

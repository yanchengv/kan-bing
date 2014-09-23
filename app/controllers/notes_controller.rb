#encoding:utf-8
class NotesController < ApplicationController
  include  NotesHelper

  before_filter :signed_in_user, except: [ :show, :index, :search_index]
  before_filter :writeable, except: [ :show, :index, :search_index, :patient_search]
  before_action :set_note, only: [:show, :edit, :update, :destroy,:share_to_my_patients]
  layout 'mapp', only: [:show, :search_index]
  # GET /notes
  # GET /notes.json
  def index
    if current_user
      if current_user.doctor_id
        if params[:tag_name]
          notes = Note.where("id in (select note_id from note_tags where tag_name = ? and created_by_id = ?)", params[:tag_name], current_user.id).publiced
        elsif params[:trash]
          notes = current_user.notes.trashed
        else
          if params[:note]
            notes = current_user.notes.where(params[:note]).order("is_top desc, updated_at desc").publiced
          else
            notes = current_user.notes.order("is_top desc, updated_at desc").publiced
          end
        end
        @note_tags = current_user.note_tags.select('distinct tag_name')
      end
      @notes = notes.paginate(:per_page => 15, :page => params[:page])
    else
      sql = 'true'
      if params[:user_id]
        @user = User.find(params[:user_id])
        if @user
          @doctor = @user.doctor
          @note_tags = @user.note_tags.select('distinct tag_name')
        end
        sql << " and created_by_id = #{params[:user_id]}"
      end
      if params[:head] && params[:head] != ''
        sql << " and head like '%#{params[:head]}%'"
      end
      if params[:archtype] && params[:archtype] != 0 && params[:archtype] != '0'
        sql << " and archtype = #{params[:archtype]}"
      end
      notes =Note.where(sql).publiced
      @notes = notes.paginate(:per_page => 15, :page => params[:page])
      render 'notes/more'
      end
  end

  def search_index
    sql = 'true'
    if params[:user_id]
      @user = User.find(params[:user_id])
      if @user
        @doctor = @user.doctor
        @note_tags = @user.note_tags.select('distinct tag_name')
      end
      sql << " and created_by_id = #{params[:user_id]}"
    end
    if params[:head] && params[:head] != ''
      sql << " and head like '%#{params[:head]}%'"
    end
    if params[:archtype] && params[:archtype] != 0 && params[:archtype] != '0'
      sql << " and archtype = #{params[:archtype]}"
    end
    notes =Note.where(sql).publiced
    @notes = notes.paginate(:per_page => 15, :page => params[:page])
    render 'notes/more'
  end

  def patient_search
    sql = 'true'
    if params[:head] && params[:head] != ''
      sql << " and head like '%#{params[:head]}%'"
    end
    notes =Note.where(sql).publiced
    @notes = notes.paginate(:per_page => 15, :page => params[:page])
    render 'notes/patient_search_notes'
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @doctor = @note.doctor
    @note.update_attribute(:pageview, @note.pageview.to_i + 1)
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
    @note.is_public = false
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
        format.json { render :show, status: :created, location: @note }
      else
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      #添加文章标签
      if params[:tag_name] && params[:tag_name] != ''
        if params[:tag_name].include?(",") || params[:tag_name].include?("，")
          names = params[:tag_name].split(/,|， */)
          names.each do |name|
            @note_tags = NoteTag.where(:note_id => @note.id, :created_by_id => @note.created_by_id, :tag_name => name)
            if @note_tags.empty?
              NoteTag.create(:note_id => @note.id, :created_by_id => @note.created_by_id, :tag_name => name)
            end
          end
        else
          @note_tags = NoteTag.where(:note_id => @note.id, :created_by_id => @note.created_by_id, :tag_name => params[:tag_name])
          if @note_tags.empty?
            NoteTag.create(:note_id => @note.id, :created_by_id => @note.created_by_id, :tag_name => params[:tag_name])
          end
        end
      end

      if @note.update(note_params)
        flash[:success] = "文章发表成功！"
        format.html { redirect_to @note }
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
      flash[:success] = "文章删除成功！"
      format.html { redirect_to :action => 'index'}
      format.json { head :no_content }
    end
  end

  def batch_del
    if params[:ids]
      @notes = Note.where("id in #{params[:ids]}")
      if @notes.delete_all
        render :json => {:success => true}
      else
        render :json => {:success => false}
      end
    else
      render :json => {:success => false}
    end
  end

  def batch_update_type
    if params[:ids] && params[:type_id]
      @notes = Note.where("id in #{params[:ids]}")
      if @notes.update_all(:archtype => params[:type_id])
        render :json => {:success => true}
      else
        render :json => {:success => false}
      end
    else
      render :json => {:success => false}
    end
  end

  def is_top
    if params[:id]
      @note = Note.find(params[:id])
      if params[:str]=='true'
        if @note.update(:is_top => 1)
          @json = {:success => true}
        else
          @json = {:success => false}
        end
      else
        if @note.update(:is_top => 0)
          @json = {:success => true}
        else
          @json = {:success => false}
        end
      end
    end
    render :json => @json
  end

  def share_to_my_patients
    if @note.share_to_my_patients
      render :json => {:success => true}
    else
      format.json { render json: @note.errors, status: :unprocessable_entity }
    end
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

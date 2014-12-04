class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy,:join,:quit]
  before_filter :is_doctor,only: [:join]
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
   @items = @group.items
   @experts = @group.experts.limit(10)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  def join
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
    else
       flash[:warning] = "您已经加入过该机构"
    end
     redirect_to  groups_path
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
    else
      flash[:warning] = "您还不是这个机构的成员"
    end
    redirect_to  groups_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end
    def is_doctor
       if current_user &&current_user.doctor_id?
       else
         flash[:notice] = "请求无效"
         puts "无效"
         redirect_to root_path
       end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :desc, :photo, :web_site, :create_user_id, :create_user, :expert_count,:sort,:doctor_id ,:doctor_name)
    end
end

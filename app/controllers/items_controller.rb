class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy,:join,:quit]
  before_action :set_group,only: [:new,:create,:join]
  before_filter :signed_in_user, except: [   :show ,:index ]
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = @group.items.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = @group.items.new(item_params)
    @item.group_name = @group.name
    respond_to do |format|
      if @item.save
        format.html { redirect_to @group, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def join
    if !current_user.is_join_of?(@item)
      current_user.join!(@item)
      flash[:success] = "您已经成功加入该项目"
    else
      flash[:warning] = "您已经加入过该项目"
    end

    if @group.nil?
      redirect_to  items_path
    else
      redirect_to  group_items_path(@group)
    end

  end

  def quit
    if current_user.is_join_of?(@item)
      current_user.quit!(@item)
    else
      flash[:warning] = "您还不是这个项目的成员"
    end
    redirect_to  items_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id]) if Group.exists?(params[:group_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :desc, :photo, :user_id, :create_user)
    end
end

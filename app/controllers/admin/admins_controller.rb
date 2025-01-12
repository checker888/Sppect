class Admin::AdminsController < Admin::Base

  before_action :admin_login_required 

  def index
    @admins = Admin.all.page(params[:page]).per(10)
  end

  def show
    @admin = Admin.find(params[:id])
  end
  def new 
    @admin = Admin.new()
  end

  
  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to admin_admins_path, notice: "管理者を追加しました。"
      
    else
      render "new"
    end
  end



  def edit
    @admin = Admin.find(params[:id])
  end




  def update
    @admin = Admin.find(params[:id])
    @admin.assign_attributes(params[:admin])
    if @admin.save
      redirect_to [:admin,@admin], notice: "管理者情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to request.referer, notice: "管理者を削除しました。"
  end
end


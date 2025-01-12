class Admin::OwnersController < Admin::Base
  before_action :admin_login_required , except:[:new,:create]
  def index
    @owners = Owner.all.page(params[:page]).per(10)
  end

  def new
    @owner = Owner.new(birthday: Date.new(1980, 1, 1))
  end

  def create
    @owner = User.new(params[:owner])
    if @owner.save
      redirect_to :admin_root, notice: "会員登録が完了しました。"
    else
      render "new"
    end
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    @owner.assign_attributes(params[:owner])
    if @owner.save
      redirect_to :admin_root, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy
    redirect_to :admin_owners, notice: "オーナーを削除しました。"
  end
end

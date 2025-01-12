class Admin::UsersController < Admin::Base

    before_action :admin_login_required , except:[:new,:create]
    def index
      @users = User.all.page(params[:page]).per(10)
    end
  
    def new
      @user = User.new(birthday: Date.new(1980, 1, 1))
    end
  
    def create
      @user = User.new(params[:user])
      if @user.save
        redirect_to :admin_root, notice: "会員登録が完了しました。"
      else
        render "new"
      end
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      @user.assign_attributes(params[:user])
      if @user.save
        redirect_to :admin_root, notice: "アカウント情報を更新しました。"
      else
        render "edit"
      end
    end

  
  def destroy
    
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :admin_users, notice: "ユーザーを削除しました。"
    
  end
end

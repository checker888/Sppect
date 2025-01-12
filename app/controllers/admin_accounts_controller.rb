class AdminAccountsController < ApplicationController
  
    before_action :admin_login_required , except:[:new,:create]
  
  
    def new
      @admin = Admin.new()
    end
  
    def create
      @owner = Owner.new(params[:owner_account])
      if @owner.save
        owner_cookies_signed_func(@owner.id)
        redirect_to :root, notice: "会員登録が完了しました。"
      else
        render "new"
      end
    end
  
    def show
      @admin = current_admin
    end
  
    def edit
      @admin = current_admin
    end
  
    def update
      @owner = current_owner
      @owner.assign_attributes(params[:owner_account])
      if @owner.save
        redirect_to :owner_account, notice: "アカウント情報を更新しました。"
      else
        render "edit"
      end
    end
  

  
end

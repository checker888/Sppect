class OwnerAccountsController < ApplicationController
  before_action :login_required , except:[:new,:create]


  def new
    @owner = Owner.new(birthday: Date.new(1980, 1, 1))
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
    @owner = current_owner
  end

  def edit
    @owner = current_owner
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

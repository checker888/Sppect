class AccountsController < ApplicationController
  before_action :login_required , except:[:new,:create]


  def new
    @user = User.new(birthday: Date.new(1980, 1, 1))
  end

  def create
    @user = User.new(params[:account])
    if @user.save
      user_cookies_signed_func(@user.id)
      redirect_to :root, notice: "会員登録が完了しました。"
    else
      render "new"
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(params[:account])
    if @user.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

end

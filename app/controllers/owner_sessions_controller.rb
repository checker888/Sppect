class OwnerSessionsController < ApplicationController
  def create
    owner = Owner.find_by(name: params[:name]) #後で追加
    if owner&.authenticate(params[:password])
      owner_cookies_signed_func(owner.id)
    else
      flash.alert = "名前とパスワードが一致しません"
    end
    redirect_to :root
  end

  def destroy
    cookies.delete(:owner_id)
    redirect_to :root
  end
end

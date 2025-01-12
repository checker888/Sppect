class AdminSessionsController < ApplicationController
  def create
    admin = Admin.find_by(name: params[:name]) #後で追加
    if admin&.authenticate(params[:password])
      admin_cookies_signed_func(admin.id)
      redirect_to :admin_spaces
    else
      flash.alert = "名前とパスワードが一致しません"
      redirect_to request.referer
    end
    
  end

  def destroy
    cookies.delete(:admin_id)
    redirect_to :admin_root
  end
end

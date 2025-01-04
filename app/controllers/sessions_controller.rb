class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:name])
    owner = Owner.find_by(name: params[:name]) #後で追加
    if user&.authenticate(params[:password])
      cookies_signed_func(user.id)
    else
      flash.alert = "名前とパスワードが一致しません"
    end
    redirect_to :root
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to :root
  end
end

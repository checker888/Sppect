class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      user_cookies_signed_func(user.id)
      redirect_to :root
    else
      flash.alert = "名前とパスワードが一致しません"
      redirect_to request.referer
    end
    
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to :root
  end
end

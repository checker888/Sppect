class UsersController < ApplicationController
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :root, notice: "退会しました。"
  end
end

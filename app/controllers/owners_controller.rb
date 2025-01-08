class OwnersController < ApplicationController

  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy
    redirect_to :root, notice: "退会しました。"
  end
end

class SpacesController < ApplicationController

  def index
    if params[:owner_id]
      @owner = Owner.find(params[:owner_id])
      @spaces = @owner.spaces
    else
      @spaces = Space.all
    end
    @spaces = @spaces.order(posted_at: :desc).page(params[:page]).per(3)
  end

  # 記事詳細
  def show
    @space = Space.find(params[:id])
    @reviews = @space.reviews

    @reviews = @reviews.order(posted_at: :desc).page(params[:page]).per(3)
  end


  def like
    @space = Space.find(params[:id])
    current_user.liked_spaces << @space
    redirect_to @space, notice: "お気に入りに登録しました。"
  end
  def unlike
    @space = Space.find(params[:id])
    current_user.liked_spaces.destroy(Space.find(params[:id]))
    # redirect_to :liked_spaces,notice: "削除しました。"
    redirect_to @space,notice: "¥お気に入りを取り消しました。"
  end

  def voted
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @spaces = @user.voted_spaces.order("likes.created_at DESC").page(params[:page]).per(15)
  end
end

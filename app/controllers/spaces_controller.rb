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
    @space = Space.published.find(params[:id])
    current_user.voted_spaces << @space
    redirect_to @space, notice: "投票しました。"
  rescue
    redirect_to @space
  end
  def unlike
    current_user.voted_spaces.destroy(Space.find(params[:id]))
    # redirect_to :voted_spaces,notice: "削除しました。"
    redirect_to :root,notice: "削除しました。"
  end
end

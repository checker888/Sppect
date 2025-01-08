class SpacesController < ApplicationController
  def search
    @spaces = Space.search(params[:q],params[:sex]).page(params[:page]).per(15)
    render "index"
  end

  def index
    if params[:owner_id]
      @owner = Owner.find(params[:owner_id])
      @spaces = @owner.spaces
    else
      @spaces = Space.where(approval: true)
    end
    @spaces = @spaces.order(posted_at: :desc).page(params[:page]).per(3)
  end

  # 記事詳細
  def show
    @space = Space.find(params[:id])
    @genres = @space.genres
    @reviews = @space.reviews
    if current_user && !current_user.review_writable_for?(@space)
      @review = current_user.reviews.find_by(space: @space)
    end
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
    redirect_to @space,notice: "お気に入りを取り消しました。"
  end

  def liked
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @spaces = @user.liked_spaces.order("likes.created_at DESC").page(params[:page]).per(15)
  end

  def new
    @space = Space.new()
  end

  def create
    @space = Space.new(params[:space])
    @space.owner = current_owner
    if @space.save
      redirect_to :root, notice: "スペース貸出を申請しました。"
      # redirect_to reservations, notice: "予約を作成しました。"
    else
      render "new"
    end
  end
end

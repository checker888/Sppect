class SpacesController < ApplicationController
  def search
    @spaces = Space.search(params[:q]).where(approval: true,available: true).page(params[:page]).per(3)
    @genre_ids = params[:genre_ids]&.select(&:present?)
    if @genre_ids.present?
      @genre_word = "ジャンル："
      @genre_ids.each do |id|
        @genre_word = @genre_word + ' ' + Genre.find(id).name if id != ""
      end
      @spaces = @spaces.joins(:space_genre_relations).where(space_genre_relations: {genre_id: @genre_ids}).group("spaces.id").having("count(*) = #{@genre_ids.length}")
    end
    @facility_ids = params[:facility_ids]&.select(&:present?)
    if @facility_ids.present?
      @facility_word = "設備："
      @facility_ids.each do |id|
        @gfacility_word = @facility_word + ' ' + Facility.find(id).name if id != ""
      end
      @spaces = @spaces.joins(:space_facility_relations).where(space_facility_relations: {facility_id: @facility_ids}).group("spaces.id").having("count(*) = #{@facility_ids.length}")
    end
    render "index"
  end

  def index
    if params[:owner_id]
      @owner = Owner.find(params[:owner_id])
      @spaces = @owner.spaces
    else
      @spaces = Space.where(approval: true,available: true)
    end
    @spaces = @spaces.order(posted_at: :desc).page(params[:page]).per(3)
  end

  # 記事詳細
  def show
    @space = Space.find(params[:id])
    @genres = @space.genres
    @facilities = @space.facilities
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


  def edit
    @owner = current_owner
    @space = current_owner.spaces.find_by(owner: @owner)
  end

  def update
    @owner = current_owner
    @space = current_owner.spaces.find_by(owner: @owner)
    @space.assign_attributes(params[:space])
    if @space.save
      redirect_to :root, notice: "スペース情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @space = current_owner.spaces.find(params[:id])
    @space.destroy
    redirect_to :root, notice: "スペースを削除しました。"
  end

  def public_available
    @space = Space.find(params[:id])
    @space.update(available: true)
    redirect_to request.referer, notice: "スペースを公開しました。"
  end
  def private_available
    @space = Space.find(params[:id])
    @space.update(available: false)
    redirect_to request.referer, notice: "スペースを非公開にしました。"
  end


end
